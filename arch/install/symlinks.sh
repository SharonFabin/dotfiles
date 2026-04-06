#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

function symlinks {
	echo "==> Setting up symlinks..."

	# Config (stow)
	cd "$DOTFILES_DIR"
	stow -v -t ~/.config .config

	# Keyd (requires sudo)
	sudo ln -sf "$DOTFILES_DIR/.config/keyd/default.conf" /etc/keyd/default.conf

	# Profile
	if [ -f ~/.profile ] && [ ! -L ~/.profile ]; then
		mv ~/.profile ~/.profile.bak
	fi
	ln -sf "$DOTFILES_DIR/.profile" ~/.profile

	# Scripts
	mkdir -p ~/.local/bin
	cd "$DOTFILES_DIR/scripts"
	stow -v -t ~/.local/bin bin

	# SDDM theme
	sudo ln -sf "$DOTFILES_DIR/.config/sddm/theme.conf" /usr/share/sddm/themes/sugar-candy/theme.conf
	sudo ln -sf "$DOTFILES_DIR/.config/sddm/Backgrounds" /usr/share/sddm/themes/sugar-candy/Backgrounds
	sudo ln -sf "$DOTFILES_DIR/.config/sddm.conf.d" /etc/sddm.conf.d
}
