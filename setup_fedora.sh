#!/usr/bin/env bash

# Install Packages
sudo yum update && sudo yum upgrade -y
sudo yum install -y $(grep -v "#" yum-packs | xargs )
