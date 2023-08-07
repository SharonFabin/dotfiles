#!/bin/bash

function installGitProgram {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "installing ${1}..."
    git clone $2 $1
    sudo chown -R $USER:$USER ./$1
    cd $1
    makepkg -si
    cd ..
    rm -rf $1
  fi
}

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    yay -S --noconfirm $1
  else
    echo "Already installed: ${1}"
  fi
}

function installPackages {
  packages=("$@")
  for package in "${packages[@]}"; do
	  install $package
  done
}

function installSnapPackage {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    snap install $1
  else
    echo "Already installed: ${1}"
  fi
}

function installSnapPackages {
  packages=("$@")
  for package in "${packages[@]}"; do
	  installSnapPackage $package
  done
}

basics=("curl" "exfat-utils" "file" "git" "htop" "btop" "nmap" "tmux" "fish" "rofi" "gvim" "xclip" "docker" "docker-compose" "alacritty" "lxappearance" "starship" "maim" "shutter-git" "xmonad" "xmonad-contrib" "xmobar" "nitrogen" "networkmanager" "nm-connection-editor" "playerctl" "pavucontrol" "i3lock" "xfce4-power-manager" "libreoffice-fresh" "libreoffice-fresh-he" "zoom" "whatsapp-nativefier" "notion-app-enhanced" "clickup" "timeshift" "imagemagick" "thunar" "thunar-volman" "thunar-archive-plugin-git" "file-roller-git" "wireshark-qt" "dunst" "xautolock" "xorg" "vlc" "firefox" "gufw" "xreader" "postman-bin" "google-chrome" "picom-jonaburg-git" "visual-studio-code-bin" "sddm-sugar-candy-git" "sddm-config-editor-git" "downgrade")

utils=("patch pkg-conifg" "xdo-git" "devour" "plocate" "cronie" "gvfs" "archlinux-keyring" "gnome-keyring" "polkit" "lxsession-gtk3" "xcape" "autorandr" "pipewire" "pipewire-pulse" "pipewire-jack" "pipewire-alsa" "pipewire-zeroconf" "wireplumber" "bluez" "bluez-utils" "blueman" "lux" "gimp")

fonts=("fontconfig" "noto-fonts-emoji"  "nerd-fonts-dejavu-complete" "nerd-fonts-terminus" "ttf-exljbris" "ttf-fira-code")

themes=("papirus-icon-theme" "plymouth-git" "sweet-gtk-theme-dark" "sweet-cursor-theme-git" "candy-icons-git")

hyprland=("hyprland xdg-desktop-portal-hyprland")

etc=("figlet" "lolcat" "neofetch")

snaps=("spotify")

installGitProgram yay https://aur.archlinux.org/yay-git.git
installPackages "${basics[@]}"
installPackages "${utils[@]}"
installPackages "${fonts[@]}"
installPackages "${themes[@]}"
installPackages "${hyprland[@]}"
installPackages "${etc[@]}"
installSnapPackages "${snaps[@]}"


