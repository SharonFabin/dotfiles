#!/bin/bash

function wallpapers {
	echo -e "${BOLD}[wallpapers]${RESET}"

	if [[ "$DRY_RUN" != "1" ]]; then
		mkdir -p ~/Pictures/screenshots
	fi

	if [[ -d ~/Pictures/wallpapers/.git ]]; then
		echo -e "  ${GREEN}Already cloned:${RESET} ~/Pictures/wallpapers"
		if [[ "$DRY_RUN" != "1" ]]; then
			echo -e "  ${BLUE}Pulling latest:${RESET} wallpapers"
			git -C ~/Pictures/wallpapers pull --ff-only 2>/dev/null || true
		fi
	elif [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would clone:${RESET} wallpapers repo to ~/Pictures/wallpapers"
	else
		echo -e "  ${BLUE}Cloning:${RESET} wallpapers repo"
		mkdir -p ~/Pictures/wallpapers
		git clone git@github.com:SharonFabin/wallpapers.git ~/Pictures/wallpapers/
	fi

	echo -e "  ${GREEN}Ready:${RESET} ~/Pictures/screenshots"
}
