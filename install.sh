#!/usr/bin/env bash
# Links the dotfiles into $HOME and installs the user-level tools they use.
# Run a prereqs-*.sh script first. Safe to run again: existing setups are kept.

set -euo pipefail

repo=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
backup="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

step() {
    printf '\n\033[1m==> %s\033[0m\n' "$*"
}

for command in git curl zsh vim; do
    if ! command -v "$command" > /dev/null; then
        echo "$command not found, run prereqs-dnf.sh or prereqs-apt.sh first" >&2
        exit 1
    fi
done

step "Linking dotfiles"
cd "$repo/files"
find . -type f -printf '%P\n' | sort | while read -r file; do
    source="$repo/files/$file"
    target="$HOME/$file"
    if [ "$(readlink "$target" 2> /dev/null)" = "$source" ]; then
        continue
    fi
    if [ -e "$target" ] || [ -L "$target" ]; then
        mkdir -p "$(dirname "$backup/$file")"
        mv "$target" "$backup/$file"
        echo "Backed up ~/$file"
    fi
    mkdir -p "$(dirname "$target")"
    ln -s "$source" "$target"
    echo "Linked ~/$file"
done
cd "$repo"
if [ -d "$backup" ]; then
    echo "Previous files are in $backup"
fi

step "Creating local config files"
for name in zshrc gitconfig gdbinit; do
    target="$HOME/.$name.local"
    if [ ! -e "$target" ]; then
        cp "$repo/templates/$name.local" "$target"
        chmod 600 "$target"
        echo "Created ~/.$name.local"
    fi
done

step "Installing Oh My Zsh"
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Already installed"
else
    # KEEP_ZSHRC stops the installer from replacing the linked ~/.zshrc
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh |
        KEEP_ZSHRC=yes sh -s -- --unattended
fi

step "Installing Oh My Zsh plugins"
plugins="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
    if [ -d "$plugins/$plugin" ]; then
        echo "$plugin already installed"
    else
        git clone --depth 1 "https://github.com/zsh-users/$plugin" "$plugins/$plugin"
    fi
done

step "Installing Hack Nerd Font"
fonts="$HOME/.local/share/fonts/NerdFonts"
if compgen -G "$fonts/HackNerdFont*" > /dev/null; then
    echo "Already installed"
else
    mkdir -p "$fonts"
    curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.tar.xz |
        tar -xJ -C "$fonts" --wildcards 'HackNerdFont*.ttf'
    fc-cache -f "$fonts"
fi

step "Installing Rust"
if command -v rustup > /dev/null || [ -x "$HOME/.cargo/bin/rustup" ]; then
    echo "Already installed"
else
    # ~/.zshenv already sources ~/.cargo/env
    curl -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

step "Installing nvm and Node.js"
if [ -s "$HOME/.nvm/nvm.sh" ]; then
    echo "Already installed"
else
    nvm_version=$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest |
        sed -nE 's/.*"tag_name": *"([^"]+)".*/\1/p')
    # PROFILE=/dev/null stops the installer from editing ~/.zshrc, which
    # already loads nvm
    curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/$nvm_version/install.sh" |
        PROFILE=/dev/null bash
    # nvm.sh isn't written for `set -u`
    set +u
    # shellcheck source=/dev/null
    . "$HOME/.nvm/nvm.sh"
    nvm install --lts
    set -u
fi

step "Setting up Vim"
mkdir -p "$HOME/.vim/tmp/undo"
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone --depth 1 https://github.com/VundleVim/Vundle.vim "$HOME/.vim/bundle/Vundle.vim"
fi
vim +PluginInstall +qall

step "Making zsh the login shell"
zsh_path=$(command -v zsh)
if [ "$(getent passwd "$USER" | cut -d: -f7)" = "$zsh_path" ]; then
    echo "Already the login shell"
else
    chsh -s "$zsh_path"
    echo "Log out and back in for the change to take effect"
fi

step "Done"
cat << 'EOF'
Machine-specific settings go in ~/.zshrc.local, ~/.gitconfig.local and
~/.gdbinit.local, which aren't tracked. To sign commits, set your key in
~/.gitconfig.local. Set the terminal font to "Hack Nerd Font Mono".
EOF
