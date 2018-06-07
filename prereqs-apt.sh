#!/bin/bash

sudo apt-get update
sudo apt-get install -y git curl zsh build-essential cmake python-dev python3-dev vim-gtk3

. /etc/os-release

# clang
if [ "$ID" = "debian" ]; then
    echo "deb https://apt.llvm.org/unstable/ llvm-toolchain main" | sudo tee /etc/apt/sources.list.d/llvm.list
    echo "deb-src https://apt.llvm.org/unstable/ llvm-toolchain main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
    echo "deb https://apt.llvm.org/unstable/ llvm-toolchain-5.0 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
    echo "deb-src https://apt.llvm.org/unstable/ llvm-toolchain-5.0 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
    echo "deb https://apt.llvm.org/unstable/ llvm-toolchain-6.0 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
    echo "deb-src https://apt.llvm.org/unstable/ llvm-toolchain-6.0 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
else
    echo "deb https://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME} main" | sudo tee /etc/apt/sources.list.d/llvm.list
    echo "deb-src https://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME} main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
    echo "deb https://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-5.0 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
    echo "deb-src https://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-5.0 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
    echo "deb https://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-6.0 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
    echo "deb-src https://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-6.0 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
fi
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-get -y install clang libclang-dev clang-tools

# node, typescript
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g typescript ts-server

# rust
curl https://sh.rustup.rs -sSf | sh
