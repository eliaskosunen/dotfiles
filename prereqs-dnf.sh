#!/bin/bash

sudo dnf -y upgrade
sudo dnf -y install git curl wget zsh automake gcc gcc-c++ make kernel-devel cmake clang clang-devel vim-enhanced vim-X11 unzip neofetch ccache util-linux-user

# node, typescript
curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash -
sudo dnf -y install nodejs
sudo npm install -g typescript ts-server

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub --noninteractive -y org.chromium.Chromium com.jetbrains.CLion com.visualstudio.code com.spotify.Client com.slack.Slack com.telegram.desktop
