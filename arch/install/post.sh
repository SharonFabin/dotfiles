#!/bin/bash

function post {
	echo "==> Running post-install tasks..."

	# Firefox theme
	if [ ! -d ~/.mozilla ]; then
		echo "Skipping Firefox theme (Firefox not set up yet)."
	else
		local tmpdir=$(mktemp -d)
		git clone https://github.com/manilarome/blurredfox.git "$tmpdir"
		cd "$tmpdir" && ./install.sh
		cd - > /dev/null
		rm -rf "$tmpdir"
	fi

	# Cursor theme fix
	if [ -d /usr/share/themes/Sweet-cursors ] && [ ! -d /usr/share/icons/Sweet-cursors ]; then
		sudo mv /usr/share/themes/Sweet-cursors /usr/share/icons/Sweet-cursors
	fi

	echo ""
	echo "==> Manual steps remaining:"
	echo "  1. Bluetooth issues: downgrade bluez to 1.58 with 'downgrade bluez'"
	echo "  2. Hebrew font fallback: update /etc/fonts/conf.d/65-nonlatin.conf"
	echo "  3. Cron jobs: copy from ~/dotfiles/arch/cron/ to /var/spool/cron/"
	echo "  4. SDDM theme: configure with sddm-config-editor"
	echo "  5. Backups: set up with timeshift-gtk"
	echo "  6. Sound issues: install sof-firmware"
	echo "  7. Mouse lag: add usbcore.autosuspend=0 to /etc/default/grub"
	echo "  8. Firewall: configure with gufw"
	echo "  9. GTK theme: configure with nwg-look"
}
