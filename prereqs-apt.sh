#!/usr/bin/env bash
# Installs system packages, repositories and Flatpak apps on Ubuntu 24.04 and
# later. Mostly the same set as prereqs-dnf.sh.

set -euo pipefail

apt_get() {
    sudo DEBIAN_FRONTEND=noninteractive apt-get "$@"
}

arch=$(dpkg --print-architecture)
# shellcheck source=/dev/null
codename=$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")

apt_get update
apt_get upgrade -y
apt_get install -y ca-certificates curl gnupg

# Steam needs 32-bit libraries, and asks to accept its license on install
sudo dpkg --add-architecture i386
echo 'steam steam/question select I AGREE' | sudo debconf-set-selections
echo 'steam steam/license note' | sudo debconf-set-selections

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null << EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $codename
Components: stable
Architectures: $arch
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo curl -fsSL https://packages.microsoft.com/keys/microsoft.asc -o /etc/apt/keyrings/microsoft.asc
sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null << EOF
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: $arch
Signed-By: /etc/apt/keyrings/microsoft.asc
EOF
apt_get update

packages=(
    # Needed by install.sh and the dotfiles
    git curl xz-utils fontconfig zsh vim-gtk3 passwd libsecret-tools

    # C and C++ development
    build-essential clang clang-tidy clang-format clangd lld lldb llvm gdb valgrind
    linux-tools-generic strace ccache cmake ninja-build mold lcov doxygen cvise
    kcachegrind

    # Other languages
    golang-go python3-pip pipx shellcheck

    # Command-line tools
    gh ripgrep jq tmux bat tree rsync dos2unix patchutils
    whois mtr-tiny netcat-openbsd tcpdump bind9-dnsutils
    age restic hcloud-cli

    # Desktop
    code gnome-tweaks gparted virt-manager
    steam-installer wine winetricks protontricks flatpak

    # Services
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
)
# fastfetch is packaged starting with Ubuntu 25.04
if apt-cache show fastfetch > /dev/null 2>&1; then
    packages+=(fastfetch)
fi
apt_get install -y "${packages[@]}"

# Packages that Ubuntu doesn't have. The Chrome package adds Google's apt
# repository for updates.
download=$(mktemp -d)
trap 'rm -rf "$download"' EXIT
if [ "$arch" = amd64 ]; then
    curl -fsSL -o "$download/chrome.deb" \
        https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt_get install -y "$download/chrome.deb"
fi
sops_version=$(curl -fsSL https://api.github.com/repos/getsops/sops/releases/latest |
    sed -nE 's/.*"tag_name": *"v([^"]+)".*/\1/p')
curl -fsSL -o "$download/sops.deb" \
    "https://github.com/getsops/sops/releases/download/v$sops_version/sops_${sops_version}_$arch.deb"
apt_get install -y "$download/sops.deb"
curl -fsSL -o "$download/install-opentofu.sh" https://get.opentofu.org/install-opentofu.sh
sh "$download/install-opentofu.sh" --install-method deb
curl -fsSL https://tailscale.com/install.sh | sh

sudo systemctl enable --now tailscaled docker
sudo usermod -aG docker "$USER"

sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

apps=(
    org.chromium.Chromium
    com.spotify.Client
    com.slack.Slack
    org.telegram.desktop
    us.zoom.Zoom
    com.mattermost.Desktop
)
if [[ ${XDG_CURRENT_DESKTOP:-} == *GNOME* ]]; then
    apps+=(com.mattjakeman.ExtensionManager)
fi
sudo flatpak install -y --noninteractive flathub "${apps[@]}"
