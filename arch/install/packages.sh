#!/bin/bash

basics=(
	# Core
	"yay" "curl" "exfat-utils" "file" "git" "htop" "btop" "nmap"

	# Shell & Terminal
	"tmux" "fish" "starship" "kitty" "ghostty"

	# Desktop
	"rofi-wayland" "playerctl" "pavucontrol"
	"thunar" "thunar-volman" "thunar-archive-plugin-git" "file-roller-git"
	"vlc" "imagemagick" "xreader"

	# Browsers
	"firefox" "brave-browser" "google-chrome"

	# Apps
	"libreoffice-fresh" "libreoffice-fresh-he"
	"zoom" "postman-bin" "wireshark-qt"

	# System
	"networkmanager" "nm-connection-editor"
	"timeshift" "gufw" "downgrade"
	"sddm" "sddm-sugar-candy-git" "sddm-config-editor-git"
	"keyd"
)

utils=(
	"patch" "plocate" "cronie"
	"gvfs" "archlinux-keyring" "gnome-keyring" "polkit"

	# Audio
	"pipewire" "pipewire-pulse" "pipewire-jack" "pipewire-alsa"
	"pipewire-zeroconf" "wireplumber"

	# Bluetooth
	"bluez" "bluez-utils" "blueman" "gnome-bluetooth-3.0"

	# Wayland
	"grimblast" "wl-clipboard" "wlsunset" "brightnessctl" "swww"

	# Tools
	"sass" "fd" "fzf" "bat" "fisher" "jq" "yq" "zoxide"
)

fonts=("fontconfig" "nerd-fonts")

themes=(
	"papirus-icon-theme" "plymouth-git"
	"sweet-gtk-theme-dark" "sweet-cursor-theme-git" "candy-icons-git"
	"nwg-look-bin"
)

hyprland=(
	"hyprland" "xdg-desktop-portal-hyprland"
	"swaylock" "aylurs-gtk-shell"
)

etc=("figlet" "lolcat" "fastfetch")

snaps=("spotify")

function _install_yay {
	if command -v yay &>/dev/null; then
		echo -e "  ${GREEN}Already installed:${RESET} yay"
		return
	fi
	if [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would install:${RESET} yay (from AUR git)"
		return
	fi
	echo -e "  ${BLUE}Installing:${RESET} yay (from AUR git)..."
	local tmpdir=$(mktemp -d)
	git clone https://aur.archlinux.org/yay-git.git "$tmpdir/yay"
	sudo chown -R "$USER:$USER" "$tmpdir/yay"
	(cd "$tmpdir/yay" && makepkg -si --noconfirm)
	rm -rf "$tmpdir"
}

function _install_pkg {
	local pkg="$1"
	if pacman -Qi "$pkg" &>/dev/null; then
		echo -e "  ${GREEN}Already installed:${RESET} $pkg"
		return
	fi
	if [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would install:${RESET} $pkg"
		return
	fi
	echo -e "  ${BLUE}Installing:${RESET} $pkg..."
	yay -S --noconfirm --needed "$pkg"
}

function _install_snap {
	local pkg="$1"
	if snap list "$pkg" &>/dev/null 2>&1; then
		echo -e "  ${GREEN}Already installed:${RESET} $pkg (snap)"
		return
	fi
	if [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would install:${RESET} $pkg (snap)"
		return
	fi
	echo -e "  ${BLUE}Installing:${RESET} $pkg (snap)..."
	sudo snap install "$pkg"
}

function packages {
	_install_yay

	local groups=("basics" "utils" "fonts" "themes" "hyprland" "etc")
	for group in "${groups[@]}"; do
		echo -e "\n${BOLD}[$group]${RESET}"
		local -n pkgs="$group"
		for pkg in "${pkgs[@]}"; do
			_install_pkg "$pkg"
		done
	done

	if command -v snap &>/dev/null; then
		echo -e "\n${BOLD}[snaps]${RESET}"
		for pkg in "${snaps[@]}"; do
			_install_snap "$pkg"
		done
	else
		echo -e "\n${YELLOW}Snap not installed, skipping snap packages.${RESET}"
	fi
}
