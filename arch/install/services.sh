#!/bin/bash

function services {
	echo "==> Configuring systemd services..."

	sudo systemctl disable lightdm.service 2>/dev/null || true
	sudo systemctl enable sddm.service
	sudo systemctl enable --now cronie
	sudo systemctl enable --now bluetooth
	sudo systemctl enable --now docker
	sudo systemctl enable --now keyd

	# Pipewire (replace pulseaudio)
	sudo pacman -Rdd --noconfirm pulseaudio 2>/dev/null || true
	sudo pacman -S --needed --noconfirm pipewire-{jack,alsa,pulse}
	systemctl --user enable --now pipewire pipewire-pulse

	# Docker group
	sudo usermod -aG docker $USER
}
