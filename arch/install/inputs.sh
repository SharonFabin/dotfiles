#!/bin/bash

function inputs {
	local src="$DOTFILES_DIR/readonly-configs/50-custominputs.conf"
	local dest="/etc/X11/xorg.conf.d/50-custominputs.conf"

	echo -e "${BOLD}[input config]${RESET}"

	if [[ ! -f "$src" ]]; then
		echo -e "  ${RED}Missing:${RESET} $src"
		return 1
	fi

	if [[ -f "$dest" ]] && diff -q "$src" "$dest" &>/dev/null; then
		echo -e "  ${GREEN}Already up to date:${RESET} $dest"
		return
	fi

	if [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would copy:${RESET} $src -> $dest"
		return
	fi

	sudo mkdir -p "$(dirname "$dest")"
	echo -e "  ${BLUE}Copying:${RESET} $src -> $dest"
	sudo cp "$src" "$dest"
}
