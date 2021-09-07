#!/bin/bash

sudo pacman -Syu --noconfirm base-devel

#install aura
sudo pacman -Syu --noconfirm stack
git clone https://github.com/fosskers/aura.git
cd aura
stack install -- aura
cd ..
rm -rf aura
export $HOME/.local/bin

#install snap
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si --noconfirm
sudo systemctl enable --now snapd.socket
cd ..
rm -rf snapd

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
install gvim # vim with extra features
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
install archlinux-keyring
install gnome-keyring
install polkit
install lxsession-gtk3
install xcape
install autorandr
install alsa
install pulseaudio
install pulseaudio-alsa
install bluez
install bluez-utils
install blueman
aur-install lux

# Image processing
install gimp

# Fonts
install fontconfig
install noto-fonts-emoji
aur-install nerd-fonts-dejavu-complete
aur-install nerd-fonts-terminus
install ttf-fira-code

# Theme
install papirus-icon-theme
aur-install plymouth-git

# Fun stuff
install figlet
install lolcat
install neofetch

