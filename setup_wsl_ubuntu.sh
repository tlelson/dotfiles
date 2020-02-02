#!/usr/bin/env bash

# This is like `setup.sh` but for WSL Ubuntu

sudo ln -s -f $(pwd)/etc_wsl.conf /etc/wsl.conf     # Mounts windows drives
ln -s -f $(pwd)/bashrc_wsl_ubuntu ~/.bashrc_local   # Liked to by `.mybashrc`

# Install Packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y $(grep -v "#" apt-packs | xargs )
