#!/bin/bash

cp -r ./files/. ~

echo "Setup Zsh"
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "Setting up aliases..."
echo "source ~/.bash_aliases" >> ~/.zshrc
echo "export DEFAULT_USER=`whoami`" >> ~/.zshrc
source ~/.zshrc

echo "Installing Powerlevel9k theme..."
git clone gh:bhilburn/powerlevel9k $ZSH_CUSTOM/themes/powerlevel9k
echo "Installing Zsh syntax highlighting plugin..."
git clone gh:zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo "Installing Zsh autosuggestions plugin..."
git clone gh:zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo "Install Powerline fonts for Zsh"
git clone gh:powerline/fonts powerline-fonts
cd powerline-fonts
./install.sh
cd ..
rm -rf powerline-fonts
reload

echo "Make Zsh the default shell"
chsh -s $(which zsh)

echo "Setup Vim"
git clone gh:amix/vimrc ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

echo "Install Vim plugins"
git clone gh:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cat vimrc-top.vim ~/.vimrc > ~/.vimrc
vim +PluginInstall +qall

echo "Build ycm_core"
EXEC_DIR=$(pwd)
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer --system-libclang --tern-completer
cd $EXEC_DIR

echo "Setup Atom"
read -r -p "Install Atom plugins? (Atom has to be installed) [y/N]" response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]]; then
    apm --version
    apm install atom-beautify autocomplete-clang busy-signal clang-format docblockr file-icons highlight-selected language-cmake language-generic-config language-llvm language-rust language-varuna linter linter-clang linter-ui-default minimap minimap-highlight-selected open-recent
fi

echo "What you need to do now:"
echo " 1) Edit ~/.zshrc:"
echo "    - Change theme to either 'agnoster' or 'powerlevel9k/powerlevel9k'"
echo "    - Add following plugins: git bower Composer git-flow pip python zsh-autosuggestions zsh-syntax-highlighting"
echo "    - Add plugin for your operating system: archlinux, debian, brew, dnf"
echo " 2) Relogin to make Zsh the default shell"
