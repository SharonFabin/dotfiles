#!/bin/bash

function _safe_link {
	local src="$1"
	local dest="$2"
	local use_sudo="${3:-false}"
	local ln_cmd="ln"
	[[ "$use_sudo" == "true" ]] && ln_cmd="sudo ln"

	if [[ -L "$dest" ]] && [[ "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
		echo -e "  ${GREEN}Already linked:${RESET} $dest"
		return
	fi

	if [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would link:${RESET} $dest -> $src"
		return
	fi

	# Backup existing file/dir (not symlink)
	if [[ -e "$dest" ]] && [[ ! -L "$dest" ]]; then
		local backup="${dest}.bak.$(date +%Y%m%d)"
		echo -e "  ${YELLOW}Backing up:${RESET} $dest -> $backup"
		if [[ "$use_sudo" == "true" ]]; then
			sudo mv "$dest" "$backup"
		else
			mv "$dest" "$backup"
		fi
	fi

	# Remove stale symlink
	if [[ -L "$dest" ]]; then
		if [[ "$use_sudo" == "true" ]]; then
			sudo rm "$dest"
		else
			rm "$dest"
		fi
	fi

	# Create parent directory if needed
	local parent="$(dirname "$dest")"
	if [[ ! -d "$parent" ]]; then
		if [[ "$use_sudo" == "true" ]]; then
			sudo mkdir -p "$parent"
		else
			mkdir -p "$parent"
		fi
	fi

	echo -e "  ${BLUE}Linking:${RESET} $dest -> $src"
	$ln_cmd -sf "$src" "$dest"
}

function symlinks {
	# Config (stow)
	echo -e "${BOLD}[stow .config]${RESET}"
	if [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would stow:${RESET} $DOTFILES_DIR/.config -> ~/.config"
		stow -n -v -t ~/.config -d "$DOTFILES_DIR" .config 2>&1 | sed 's/^/  /'
	else
		cd "$DOTFILES_DIR"
		stow -v --adopt -t ~/.config .config 2>&1 | sed 's/^/  /'
		# Reset any adopted changes
		git checkout -- .config/ 2>/dev/null || true
	fi

	# Keyd
	echo -e "\n${BOLD}[system configs]${RESET}"
	_safe_link "$DOTFILES_DIR/.config/keyd/default.conf" "/etc/keyd/default.conf" true

	# Profile
	echo -e "\n${BOLD}[shell profile]${RESET}"
	_safe_link "$DOTFILES_DIR/.profile" "$HOME/.profile"

	# Scripts
	echo -e "\n${BOLD}[stow scripts]${RESET}"
	if [[ "$DRY_RUN" != "1" ]]; then
		mkdir -p ~/.local/bin
	fi
	if [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would stow:${RESET} scripts/bin -> ~/.local/bin"
		stow -n -v -t ~/.local/bin -d "$DOTFILES_DIR/scripts" bin 2>&1 | sed 's/^/  /'
	else
		cd "$DOTFILES_DIR/scripts"
		stow -v -t ~/.local/bin bin 2>&1 | sed 's/^/  /'
	fi

	# Claude Code statusline
	echo -e "\n${BOLD}[claude]${RESET}"
	_safe_link "$DOTFILES_DIR/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"

	# SDDM
	echo -e "\n${BOLD}[sddm]${RESET}"
	if ! command -v sddm &>/dev/null; then
		echo -e "  ${YELLOW}Skipping:${RESET} sddm not installed (run packages step first)"
	else
		# SDDM config (sets theme to sugar-candy)
		_safe_link "$DOTFILES_DIR/.config/sddm.conf.d" "/etc/sddm.conf.d" true

		# Sugar-candy theme config + wallpaper
		if [[ -d /usr/share/sddm/themes/sugar-candy ]]; then
			_safe_link "$DOTFILES_DIR/.config/sddm/theme.conf" "/usr/share/sddm/themes/sugar-candy/theme.conf" true
			_safe_link "$DOTFILES_DIR/.config/sddm/Backgrounds" "/usr/share/sddm/themes/sugar-candy/Backgrounds" true
		else
			echo -e "  ${YELLOW}Skipping:${RESET} sugar-candy theme not installed yet"
		fi
	fi
}
