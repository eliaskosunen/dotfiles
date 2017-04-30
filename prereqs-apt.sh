#!/bin/bash

git --version || sudo apt-get install -y git
curl --version || sudo apt-get install -y curl

sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install -y zsh atom
