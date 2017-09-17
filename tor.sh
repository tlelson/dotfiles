#!/usr/bin/env bash

## This script configures the socks proxy and runs tor.
## It is equivalent to open Network Preferences and Configure the Socks yourself
## and then run Tor.
## N.B I have set a Location 'Tor' so that the setting are easy to switch over
## and other settings in 'Automatic' wont be lost

# 'Wi-Fi' or 'Ethernet' or 'Display Ethernet'
INTERFACE=Wi-Fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Let's roll
sudo networksetup -setsocksfirewallproxy $INTERFACE 127.0.0.1 9050 off
sudo networksetup -setsocksfirewallproxystate $INTERFACE on
tor
sudo networksetup -setsocksfirewallproxystate $INTERFACE off
