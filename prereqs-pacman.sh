#!/bin/bash

sudo pacman -Sy curl git zsh gvim clang npm python2 python base-devel go nodejs npm unzip
sudo npm install -g typescript ts-server

curl https://sh.rustup.rs -sSf | sh
