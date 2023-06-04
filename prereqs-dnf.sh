#!/bin/bash

sudo dnf update -y
sudo dnf install -y tailscale neofetch
sudo dnf group install -y "Development Tools" "C Development Tools and Libraries" "Hardware Support" "Sound and Video" "Fonts"

sudo dnf config-manager -y --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
sudo dnf install -y tailscale
sudo systemctl enable --now tailscaled

sudo flatpak install flathub --noninteractive -y org.chromium.Chromium com.visualstudio.code com.spotify.Client com.slack.Slack org.telegram.desktop
