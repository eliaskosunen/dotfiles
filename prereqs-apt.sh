#!/bin/bash

sudo apt-get update
sudo apt-get install -y git curl zsh build-essential cmake vim-gtk3 unzip

# node, typescript
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g typescript ts-server

# rust
curl https://sh.rustup.rs -sSf | sh
