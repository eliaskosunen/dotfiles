#!/usr/bin/env bash

# Shortcuts
alias c="cd ~/code"
alias p="cd ~/code/projects"
alias gti="git"

# List all files in colorized long format
alias ll="ls -lF --color"

# List all files in colorized long format, including dotfiles
alias la="ls -laF --color"

# List only directories
alias lsd="ls -lF --color | grep --color=never '^d'"

# Always enable colored `grep` output
alias grep='grep --color=auto'

alias sudo='sudo '

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# IP addresses of all interfaces
alias ips='ip -brief address'

# Ubuntu installs bat as batcat
if ! command -v bat > /dev/null && command -v batcat > /dev/null; then
    alias bat="batcat"
fi

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Seem like a 1337 HaXX0r
alias hax="cat /dev/urandom | hd"

#export CMAKE_GENERATOR='Ninja'
export CMAKE_C_COMPILER_LAUNCHER='ccache'
export CMAKE_CXX_COMPILER_LAUNCHER='ccache'
#export LDFLAGS='-fuse-ld=mold'

export CLAUDE_STATUSLINE_NERDFONT=1
