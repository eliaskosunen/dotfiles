#!/bin/bash

sudo apt-get update
sudo apt-get install -y git curl zsh build-essential cmake python-dev python3-dev vim-gtk3 unzip
sudo apt-get -y install clang libclang-dev clang-tools

# node, typescript
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g typescript ts-server

# rust
curl https://sh.rustup.rs -sSf | sh
