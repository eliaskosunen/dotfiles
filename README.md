# dotfiles
My dotfile setup

## Features

* Various shell aliases, see `.bash_aliases`
* Installs zsh, oh-my-zsh, some plugins and makes zsh the login shell
* Installs atom with plugins
* Installs custom `.gitconfig`
* Installs (g)vim with [Awesome vimrc](https://github.com/amix/vimrc)
* Also installs Vuncle.vim with YouCompleteMe, clang-format and user-operator

## Install
First, clone the repository:

```sh
git clone https://github.com/eliaskosunen/dotfiles ~/dotfiles
```

Alternatively, download the tarball if you don't want to use git.
Please note that the script will install git if it isn't present in the system.

After that, run the prerequisite installer. There are three scripts for three package managers: `apt` (Debian, \*Ubuntu), `dnf` (Fedora) and `pacman` (Arch).

Finally, run the actual installation script `install.sh`. Back up your dotfiles before running it, because the script may replace them.

The script will give additional instructions in the end to finish the setup.

## License

Unlicense (Public domain), see LICENSE for details
