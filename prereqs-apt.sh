#!/bin/bash

git --version || sudo apt-get install -y git
curl --version || sudo apt-get install -y curl
wget --version || sudo apt-get install -y wget
zsh --version || sudo apt-get install -y zsh 

wget https://github.com/atom/atom/releases/download/v1.16.0/atom-amd64.deb
sudo dpkg -i atom-amd64.deb
