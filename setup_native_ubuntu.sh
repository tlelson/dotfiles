#!/usr/bin/env bash

# Install Packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y $(grep -v "#" apt-packs | xargs )
