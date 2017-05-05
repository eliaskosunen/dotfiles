#!/bin/bash

sudo apt-get install -y git curl wget zsh libclang-dev build-essential cmake python-dev python3-dev npm

wget https://github.com/atom/atom/releases/download/v1.16.0/atom-amd64.deb
sudo dpkg -i atom-amd64.deb

curl https://sh.rustup.rs -sSf | sh
