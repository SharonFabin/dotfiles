#!/bin/bash

sudo pamac update

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
install fish
install vim
install ttf-fira-code
install docker
install alacritty
install starship
install scrot
install xmonad
install xmonad-contrib
install xmobar
install nitrogen
install picom
install trayer
install nm-applet

# Image processing
install gimp

# Fun stuff
install figlet
install lolcat
install neofetch

