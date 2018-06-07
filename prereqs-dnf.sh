#!/bin/bash

sudo dnf -y install git curl wget zsh automake gcc gcc-c++ make kernel-devel cmake python-devel python3-devel clang clang-devel vim-X11 unzip

# node, typescript
curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash -
sudo dnf -y install nodejs
sudo npm install -g typescript ts-server

# rust
curl https://sh.rustup.rs -sSf | sh
