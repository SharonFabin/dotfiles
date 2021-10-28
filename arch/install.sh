#!/bin/bash

sudo pacman -Syu --noconfirm base-devel

#install aura
sudo pacman -Syu --noconfirm stack
git clone https://github.com/fosskers/aura.git
cd aura
stack install -- aura
cd ..
rm -rf aura
export PATH="$HOME/.local/bin:$PATH"

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
install curl
install exfat-utils
install file
install git
install htop
install btop
install nmap
install tmux
install fish
install rofi
install vi
install gvim # vim with extra features
install docker
install alacritty
install lxappearance
install starship
install maim
aur-install shutter-git
install xmonad
install xmonad-contrib
install xmobar
install nitrogen
install nm-applet
install nm-connection-editor
install playerctl
install pavucontrol
install i3lock
install xfce4-power-manager
install libreoffice-fresh
install libreoffice-fresh-he
aur-install zoom
aut-install whatsapp-nativefier
aur-install notion-app-enhanced
aur-install clickup
aur-install timeshift
install imagemagick
install thunar
install thunar-volman
aur-install thunar-archive-plugin-git
aur-install file-roller-git
install wireshark-qt
install dunst
install xautolock
install xorg
install vlc
install firefox
install gufw
install xreader
aur-install postman-bin
aur-install google-chrome
aur-install picom-jonaburg-git
aur-install visual-studio-code-bin
aur-install sddm-sugar-candy-git
aur-install downgrade

# Utils
aur-install xdo-git
aur-install devour
install plocate
install cronie
install gvfs
install archlinux-keyring
install gnome-keyring
install polkit
install lxsession-gtk3
install xcape
install autorandr
install alsa
install pulseaudio
install pulseaudio-alsa
install pulseaudio-bluetooth
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
aur-install ttf-exljbris
install ttf-fira-code

# Theme
install papirus-icon-theme
aur-install plymouth-git
aur-install sweet-gtk-theme-dark
aur-install sweet-cursor-theme-git
aur-install candy-icons-git

# Fun stuff
install figlet
install lolcat
install neofetch

