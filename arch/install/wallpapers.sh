#!/bin/bash

function wallpapers {
	echo "==> Setting up wallpapers..."
	mkdir -p ~/Pictures/wallpapers
	mkdir -p ~/Pictures/screenshots

	if [ ! -d ~/Pictures/wallpapers/.git ]; then
		git clone git@github.com:SharonFabin/wallpapers.git ~/Pictures/wallpapers/
	else
		echo "Wallpapers repo already cloned."
	fi
}
