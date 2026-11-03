#!/usr/bin/env bash
# Installs system packages, repositories and Flatpak apps on Fedora 44 and later.

set -euo pipefail

sudo dnf upgrade -y --refresh

sudo dnf install -y fedora-workstation-repositories dnf5-plugins flatpak

# Google Chrome, and the RPM Fusion NVIDIA driver and Steam repositories, come
# with fedora-workstation-repositories, disabled
sudo dnf config-manager setopt google-chrome.enabled=1 rpmfusion-nonfree-steam.enabled=1
if lspci -d 10de: | grep -qE 'VGA|3D'; then
    sudo dnf config-manager setopt rpmfusion-nonfree-nvidia-driver.enabled=1
fi

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo tee /etc/yum.repos.d/vscode.repo > /dev/null << 'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

sudo dnf config-manager addrepo --overwrite \
    --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf config-manager addrepo --overwrite \
    --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

sudo dnf group install -y \
    development-tools c-development hardware-support sound-and-video fonts

packages=(
    # Needed by install.sh and the dotfiles
    git curl zsh vim-enhanced vim-X11 util-linux libsecret

    # C and C++ development
    clang clang-tools-extra lld lldb llvm gdb valgrind perf strace
    ccache cmake ninja-build mold libatomic lcov doxygen cvise kcachegrind

    # Other languages
    golang python3-pip pipx ShellCheck

    # Command-line tools
    fastfetch gh ripgrep jq tmux bat tree rsync dos2unix patchutils
    whois mtr nmap-ncat tcpdump bind-utils
    age restic opentofu hcloud

    # Desktop
    google-chrome-stable code gnome-tweaks gparted virt-manager
    steam wine winetricks protontricks

    # Services
    tailscale
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
)
sudo dnf install -y "${packages[@]}"

# sops isn't packaged in Fedora
sops_version=$(curl -fsSL https://api.github.com/repos/getsops/sops/releases/latest |
    sed -nE 's/.*"tag_name": *"v([^"]+)".*/\1/p')
sudo dnf install -y \
    "https://github.com/getsops/sops/releases/download/v$sops_version/sops-$sops_version-1.$(uname -m).rpm"

sudo systemctl enable --now tailscaled docker
sudo usermod -aG docker "$USER"

# Fedora ships Flathub filtered down to a few apps
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --no-filter --enable flathub

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
