#!/bin/bash

sudo dnf install fedora-repos-rawhide copr-cli
sudo dnf copr enable mosquito/atom
sudo dnf install git curl wget atom zsh automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel npm clang clang-devel

curl https://sh.rustup.rs -sSf | sh
