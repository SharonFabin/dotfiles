#!/bin/bash

sudo pacman -Syu --noconfirm base-devel

#install aura
sudo pacman -Syu --noconfirm stack &&
git clone https://github.com/fosskers/aura.git &&
cd aura &&
stack install -- aura &&
cd .. &&
rm -rf aura &&
export PATH="$HOME/.local/bin:$PATH"


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

aur-install snapd &&
sudo systemctl enable --now snapd.socket

# Basics
pacman_install="curl exfat-utils file git htop btop nmap tmux fish rofi vi gvim xclip docker alacritty lxappearance starship maim xmonad xmonad-contrib xmobar nitrogen networkmanager nm-connection-editor playerctl pavucontrol i3lock xfce4-power-manager libreoffice-fresh libreoffice-fresh-he imagemagick thunar thunar-volman wireshark-qt dunst xautolock xorg vlc firefox gufw xreader plocate cronie gvfs archlinux-keyring gnome-keyring polkit lxsession-gtk3 xcape autorandr alsa pulseaudio pulseaudio-alsa pulseaudio-bluetooth bluez bluez-utils blueman gimp fontconfig noto-fonts-emoji ttf-fira-code papirus-icon-theme figlet lolcat neofetch"

aur_install="zoom whatsapp-nativefier notion-app-enhanced clickup timeshift thunar-archive-plugin-git file-roller-git postman-bin google-chrome picom-jonaburg-git visual-studio-code-bin sddm-sugar-candy-git sddm-config-editor-git downgrade xdo-git devour lux nerd-fonts-dejavu-complete nerd-fonts-terminus ttf-exljbris plymouth-git sweet-gtk-theme-dark sweet-cursor-theme-git candy-icons-git shutter-git"

sudo pacman -S --noconfirm $pacman_install
sudo aura -A --noconfirm $aur_install
