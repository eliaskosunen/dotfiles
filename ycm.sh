EXEC_DIR=$(pwd)

echo " ***** Build ycm_core ***** "
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --ts-completer --rust-completer
cd $EXEC_DIR

vim +PluginInstall +qall

