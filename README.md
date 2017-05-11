# dotfiles
My dotfile setup

## Disclaimer

THE INSTALLATION SCRIPT `install.sh` WILL OVERWRITE SOME OF YOUR DOTFILES.
I take no responsibility should you lose some or all of your personal configuration. 

To get the list of files to be overwritten, see the directory `files`.
Back the similarly named files from your home directory should you ever want to go back.

You've been warned.

## Features

* Various shell aliases, see `.bash_aliases`
* Installs zsh, oh-my-zsh, some plugins and makes zsh the login shell
* Installs custom `.gitconfig`
* Installs vim with Vuncle.vim and some plugins, for example YouCompleteMe

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
