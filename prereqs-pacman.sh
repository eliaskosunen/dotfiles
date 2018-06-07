#!/bin/bash

sudo pacman -Sy curl git zsh gvim clang npm python2 python base-devel mono jre8-openjdk jdk8-openjdk go nodejs npm
sudo npm install -g typescript ts-server

curl https://sh.rustup.rs -sSf | sh
