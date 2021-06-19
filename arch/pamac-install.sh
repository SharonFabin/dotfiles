#!/bin/bash

sudo apt update

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo pamac install --no-confirm $1
  else
    echo "Already installed: ${1}"
  fi
}

# Basics
install base-devel
install curl
install exfat-utils
install file
install git
install htop
install nmap
install tmux
install vim
install ttf-fira-code
install docker

# Image processing
install gimp

# Fun stuff
install figlet
install lolcat

