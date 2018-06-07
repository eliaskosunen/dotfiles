#!/bin/bash

sudo apt-get update
sudo apt-get install -y git curl wget zsh libclang-dev build-essential cmake python-dev python3-dev vim-gtk3 openjdk-8-jdk openjdk-8-jre golang-go

# node, typescript
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g typescript ts-server

# mono
sudo apt install dirmngr || true
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
sudo apt install apt-transport-https || true
. /etc/os-release
if [ "$ID" = "debian" ]; then
    echo "deb https://download.mono-project.com/repo/debian stable-stretch main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
else
    echo "deb https://download.mono-project.com/repo/ubuntu stable-${UBUNTU_CODENAME} main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
fi
sudo apt update
sudo apt install -y mono-complete

# rust
curl https://sh.rustup.rs -sSf | sh
