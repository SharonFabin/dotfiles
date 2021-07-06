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
echo "Things to setup:"
echo "1. natural input scrolling"
echo "2. gtk theme with lxappearance"
echo "3. xmonad.hs"
echo "4. If you have bluetooth problems (particulary A2DP profile problem), downgrade bluez to 1.58 with pamac install downgrade"
figlet "...and we're back!" | lolcat

