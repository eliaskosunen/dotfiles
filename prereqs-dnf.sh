#!/bin/bash

git --version || sudo dnf install git
curl --version || sudo dnf install curl

sudo dnf install fedora-repos-rawhide copr-cli
sudo dnf copr enable mosquito/atom
sudo dnf install atom zsh
