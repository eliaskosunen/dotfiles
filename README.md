# dotfiles

My shell, git, Vim and gdb configuration, and scripts that set up a new machine
with it.
The scripts are written for Fedora (44 and 45) and Ubuntu (24.04 and 26.04).

## What's included

The files in `files/` are linked into the home directory at the same paths:

 - `.zshrc`: Oh My Zsh with the agnoster theme, and helpers for loading secrets
   from the keyring
 - `.zshenv`: sets up the Rust toolchain environment
 - `.bash_aliases`: aliases and build environment variables, used by zsh too
 - `.gitconfig` and `.config/git/ignore`: git settings and the global ignore list
 - `.vimrc`: Vim settings, with plugins managed by Vundle
 - `.gdbinit`: gdb settings

## Installation

Clone the repository, install the system packages, then run `install.sh`:

```sh
git clone https://github.com/eliaskosunen/dotfiles ~/code/projects/dotfiles
cd ~/code/projects/dotfiles
./prereqs-dnf.sh    # Fedora
./prereqs-apt.sh    # Ubuntu
./install.sh
```

The prereqs scripts install C and C++ development tools, command-line tools, and
the desktop apps I use (Chrome, VS Code, Steam, and Flatpak apps from Flathub),
and set up Docker and Tailscale.
They install mostly the same set on both distributions, adding the third-party
repositories that are needed.
Note that they're meant for a desktop machine, not a server.

`install.sh` links the dotfiles, and installs Oh My Zsh with its plugins, the
Hack Nerd Font, Rust (through rustup), Node.js (through nvm) and the Vim plugins.
It makes zsh the login shell, too.
Existing files in the way are moved to `~/.dotfiles-backup/<date>/`, so nothing
is overwritten.
It's safe to run again: links that already exist and tools that are already
installed are left alone.

To keep shell startup fast, `.zshrc` loads nvm only when `nvm` is first run, so
`node` isn't in `PATH` until, e.g., `nvm use` has been run in that shell.

Because the dotfiles are symbolic links into the repository, editing
`~/.zshrc` edits the file in the repository, and the change shows up in
`git status`.
The same applies to tools that edit these files themselves, e.g.,
`git config --global`.

## Machine-specific settings

`install.sh` creates three files from `templates/` that aren't tracked:

 - `~/.zshrc.local`, sourced at the end of `~/.zshrc`
 - `~/.gitconfig.local`, included at the end of `~/.gitconfig`, e.g., for the
   commit signing key
 - `~/.gdbinit.local`, sourced from `~/.gdbinit`, e.g., for
   `add-auto-load-safe-path`

To write git settings there instead of into the tracked file, use
`git config --file ~/.gitconfig.local`, or for `git maintenance`,
`git maintenance register --config-file ~/.gitconfig.local`.

## Secrets

Secrets, such as API tokens, are kept in the login keyring (GNOME Keyring or
KWallet), not in a file.
To store one, run:

```sh
secret-tool store --label=EXAMPLE_TOKEN env EXAMPLE_TOKEN
```

`.zshrc` defines two functions for reading them back.
`keyring_export NAME...` exports secrets to the shell, and is meant to be called
from `~/.zshrc.local`.
`with_secrets NAME... -- command args...` passes secrets to a single command
only, so that other programs started from the shell can't read them.
Prefer `with_secrets` when only one tool needs the secret.

Note that the keyring is unlocked when logging in to a desktop session.
Over SSH, or on a machine without one, `secret-tool` can't read it.
`keyring_export` then skips the secret, and `with_secrets` fails.

## License

Public domain (the Unlicense), see `LICENSE`.
