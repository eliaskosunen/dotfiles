#!/bin/zsh

echo " ***** Remove Oh My Zsh ***** "
rm -rf ~/.oh-my-zsh

echo " ***** Install dotfiles ***** "
cp -r ./files/. ~

echo " ***** Setup Zsh ***** "
echo " ***** Installing Oh My Zsh ***** "
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo " ***** Setting up aliases ***** "
echo "source ~/.bash_aliases" >> ~/.zshrc
echo "export DEFAULT_USER=`whoami`" >> ~/.zshrc
source ~/.profile
source ~/.zshrc

echo " ***** Installing Powerlevel9k theme ***** "
git clone gh:bhilburn/powerlevel9k $ZSH_CUSTOM/themes/powerlevel9k
echo " ***** Installing Zsh syntax highlighting plugin ***** "
git clone gh:zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo " ***** Installing Zsh autosuggestions plugin ***** "
git clone gh:zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo " ***** Install Powerline fonts for Zsh ***** "
git clone gh:powerline/fonts powerline-fonts
cd powerline-fonts
./install.sh
cd ..
rm -rf powerline-fonts

echo " ***** Make Zsh the default shell ***** "
chsh -s $(which zsh)

echo " ***** Install Hack (font) ***** "
get_latest_github_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" |
        grep '"tag_name":' |
        sed -E 's/.*"([^"]+)".*/\1/'
}
HACK_VERSION=$(get_latest_github_release "source-foundry/Hack")
curl -sL https://github.com/source-foundry/Hack/releases/download/${HACK_VERSION}/Hack-${HACK_VERSION}-ttf.tar.gz | tar xz
mkdir -p ~/.fonts/hack
cp ttf/* ~/.fonts/hack
rm -rf ttf
sudo fc-cache -fv

echo " ***** Setup Vim ***** "
EXEC_DIR=$(pwd)
mkdir -p ~/.vim/tmp ~/.vim/colors
git clone gh:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir ~/.vim/tmp/backup ~/.vim/tmp/undo
cd $EXEC_DIR
vim +PluginInstall +qall
cp ~/.vim/bundle/vim-colorschemes/colors/* ~/.vim/colors

echo "What you need to do now:"
echo " 1) Edit ~/.zshrc:"
echo "    - Change theme to either 'agnoster' or 'powerlevel9k/powerlevel9k'"
echo "    - Add following plugins: command-not-found colored-man-pages colorize cp git extract node npm pip python virtualenv web-search zsh-autosuggestions zsh-syntax-highlighting"
echo "    - Add plugin for your operating system: archlinux, debian, brew, dnf, systemd"
echo "    - Export 'vim' as EDITOR"
echo " 2) Relogin to make Zsh the default shell"
