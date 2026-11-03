# Drop duplicate entries, e.g., when ~/.profile has already added some
typeset -U path PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(
    command-not-found
    colored-man-pages
    colorize
    cp
    git
    extract
    node
    npm
    pip
    python
    systemd
    zsh-autosuggestions
    zsh-syntax-highlighting
)
if (( $+commands[dnf] )); then
    plugins+=(dnf)
elif (( $+commands[apt-get] )); then
    plugins+=(debian)
fi

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='vim'

source ~/.bash_aliases

# agnoster hides user@host in the prompt when the user is DEFAULT_USER
export DEFAULT_USER=$USER

# Loading nvm takes most of the shell startup time, so it's loaded only when
# `nvm` is first run. Until then, node isn't in PATH.
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}

# Export secrets stored in the login keyring (GNOME Keyring, KWallet).
# Store one with `secret-tool store --label=NAME env NAME`.
# Call this from ~/.zshrc.local with the names to export.
keyring_export() {
    (( $+commands[secret-tool] )) || return 1
    local name value
    for name in "$@"; do
        value=$(secret-tool lookup env "$name" 2>/dev/null)
        [[ -n $value ]] || continue
        export "$name=$value"
    done
}

# Run a single command with secrets from the keyring, without exporting them
# to the shell: `with_secrets NAME... -- command args...`
with_secrets() {
    (( $+commands[secret-tool] )) || return 1
    local -a assignments
    local value
    while (( $# )) && [[ $1 != -- ]]; do
        value=$(secret-tool lookup env "$1" 2>/dev/null)
        [[ -n $value ]] || {
            print -u2 "with_secrets: $1 not found in the keyring"
            return 1
        }
        assignments+=("$1=$value")
        shift
    done
    if (( ! $# )); then
        print -u2 "usage: with_secrets NAME... -- command args..."
        return 2
    fi
    shift
    env "${assignments[@]}" "$@"
}

# Machine-specific settings and secrets, not tracked in the dotfiles repo
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
