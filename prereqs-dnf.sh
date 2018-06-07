#!/bin/bash

sudo dnf -y install git curl wget zsh automake gcc gcc-c++ make kernel-devel cmake python-devel python3-devel clang clang-devel vim-X11 golang java-1.8.0-openjdk-devel.x86_64
java-1.8.0-openjdk.x86_64

# node, typescript
curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash -
sudo dnf -y install nodejs
sudo npm install -g typescript ts-server

# mono
rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
sudo curl https://download.mono-project.com/repo/centos7-stable.repo | sudo tee /etc/yum.repos.d/mono-centos7-stable.repo
sudo dnf update
sudo fnt install mono-complete

# rust
curl https://sh.rustup.rs -sSf | sh
