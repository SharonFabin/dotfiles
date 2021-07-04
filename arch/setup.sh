#!/bin/bash

./symlink.sh
./pamac_install.sh
./install_programs.sh

# Give execute permissions for all scripts
chmod -R +x ./scripts

# Get all upgrades
# sudo apt upgrade -y

# See our bash changes
# source ~/.bashrc

# Fun hello
figlet "dont forget to link xmonad.hs, and we're back!" | lolcat

