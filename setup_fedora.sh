#!/usr/bin/env bash

# Install Packages
#sudo dnf update && sudo dnf upgrade -y
sudo dnf install -y $(grep -v "#" dnf-packs | xargs )
