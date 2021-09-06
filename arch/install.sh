#!/bin/bash

sudo pacman -Syu --noconfirm base-devel
sudo pacman -Syu --noconfirm stack
git clone https://github.com/fosskers/aura.git
cd aura
stack install -- aura
cd ..
rm -rf aura
export $HOME/.local/bin

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo aura -Syu --noconfirm $1
  else
    echo "Already installed: ${1}"
  fi
}

function aur-install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo aura -A --noconfirm $1
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
install rofi
install vim
install docker
install alacritty
install starship
install maim
install xmonad
install xmonad-contrib
install xmobar
install nitrogen
install trayer
install nm-applet
install playerctl
install i3lock
install imagemagick
install thunar
install dolphin
install dunst
install xautolock
install xorg
aur-install google-chrome
aur-install picom-jonaburg-git
aur-install visual-studio-code-bin
aur-install chili-sddm-theme

# Utils
install autorandr
install alsa
install pulseaudio
install pulseaudio-alsa
aur-install lux

# Image processing
install gimp

# Fonts
install ttf-fira-code
aur-install nerd-fonts-terminus
aur-install nerd-fonts-fira-code

# Theme
install papirus-icon-theme
aur-install plymouth-git

# Fun stuff
install figlet
install lolcat
install neofetch

