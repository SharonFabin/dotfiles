#!/bin/bash

function installGitProgram {
	which $1 &>/dev/null

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
	which $1 &>/dev/null

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
	which $1 &>/dev/null

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

basics=("yay" "curl" "exfat-utils" "file" "git" "htop" "btop" "nmap" "tmux" "fish" "rofi" "xclip" "alacritty" "lxappearance" "starship" "networkmanager" "nm-connection-editor" "playerctl" "pavucontrol" "i3lock" "xfce4-power-manager" "libreoffice-fresh" "libreoffice-fresh-he" "zoom" "whatsapp-nativefier" "notion-app-enhanced" "timeshift" "imagemagick" "thunar" "thunar-volman" "thunar-archive-plugin-git" "file-roller-git" "wireshark-qt" "xautolock" "vlc" "firefox" "brave-browser" "gufw" "xreader" "postman-bin" "google-chrome" "sddm-sugar-candy-git" "sddm-config-editor-git" "downgrade" "keyd" "kitty")

utils=("patch pkg-conifg" "xdo-git" "devour" "plocate" "cronie" "gvfs" "archlinux-keyring" "gnome-keyring" "polkit" "lxsession-gtk3" "xcape" "autorandr" "pipewire" "pipewire-pulse" "pipewire-jack" "pipewire-alsa" "pipewire-zeroconf" "wireplumber" "bluez" "bluez-utils" "blueman" "lux" "gimp", "grimblast", "wl-clipboard", "wlsunset", "gnome-bluetooth-3.0", "brightnessctl", "sass", "fd", "swww")

fonts=("fontconfig" "nerd-fonts")

themes=("papirus-icon-theme" "plymouth-git" "sweet-gtk-theme-dark" "sweet-cursor-theme-git" "candy-icons-git" "nwg-look-bin")

hyprland=("hyprland" "xdg-desktop-portal-hyprland" "swaylock" "aylurs-gtk-shell")

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
