#!/bin/bash

function post {
	echo -e "${BOLD}[cursor theme fix]${RESET}"
	if [[ -d /usr/share/icons/Sweet-cursors ]]; then
		echo -e "  ${GREEN}Already moved:${RESET} Sweet-cursors"
	elif [[ -d /usr/share/themes/Sweet-cursors ]]; then
		if [[ "$DRY_RUN" == "1" ]]; then
			echo -e "  ${YELLOW}Would move:${RESET} Sweet-cursors to icons dir"
		else
			echo -e "  ${BLUE}Moving:${RESET} Sweet-cursors to icons dir"
			sudo mv /usr/share/themes/Sweet-cursors /usr/share/icons/Sweet-cursors
		fi
	else
		echo -e "  ${YELLOW}Skipping:${RESET} Sweet-cursors theme not found"
	fi

	echo -e "\n${BOLD}[firefox theme]${RESET}"
	if [[ ! -d ~/.mozilla ]]; then
		echo -e "  ${YELLOW}Skipping:${RESET} Firefox not set up yet (run Firefox once first)"
	elif [[ -d ~/.mozilla/firefox/*/chrome/blurredfox ]]; then
		echo -e "  ${GREEN}Already installed:${RESET} blurredfox theme"
	elif [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would install:${RESET} blurredfox Firefox theme"
	else
		echo -e "  ${BLUE}Installing:${RESET} blurredfox Firefox theme"
		local tmpdir=$(mktemp -d)
		git clone --depth 1 https://github.com/manilarome/blurredfox.git "$tmpdir"
		(cd "$tmpdir" && ./install.sh)
		rm -rf "$tmpdir"
	fi

	echo -e "\n${BOLD}[manual steps]${RESET}"
	echo -e "  ${YELLOW}1.${RESET} Bluetooth issues: downgrade bluez with 'downgrade bluez'"
	echo -e "  ${YELLOW}2.${RESET} Hebrew font fallback: update /etc/fonts/conf.d/65-nonlatin.conf"
	echo -e "  ${YELLOW}3.${RESET} Cron jobs: copy from ~/dotfiles/arch/cron/ to /var/spool/cron/"
	echo -e "  ${YELLOW}4.${RESET} SDDM theme: configure with sddm-config-editor"
	echo -e "  ${YELLOW}5.${RESET} Backups: set up with timeshift-gtk"
	echo -e "  ${YELLOW}6.${RESET} Sound issues: install sof-firmware"
	echo -e "  ${YELLOW}7.${RESET} Mouse lag: add usbcore.autosuspend=0 to /etc/default/grub"
	echo -e "  ${YELLOW}8.${RESET} Firewall: configure with gufw"
	echo -e "  ${YELLOW}9.${RESET} GTK theme: configure with nwg-look"
}
