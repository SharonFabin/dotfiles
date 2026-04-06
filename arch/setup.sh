#!/bin/bash
set -euo pipefail

# --- Constants ---
export DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DRY_RUN="${DRY_RUN:-0}"

# --- Colors ---
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export BOLD='\033[1m'
export RESET='\033[0m'

# --- Source modules ---
for module in "$DOTFILES_DIR"/install/*.sh; do
	source "$module"
done

# --- Steps ---
STEPS=(packages symlinks services fonts inputs wallpapers post)

function usage {
	echo -e "${BOLD}Usage:${RESET} ./setup.sh [options] [step]"
	echo ""
	echo -e "${BOLD}Options:${RESET}"
	echo "  --dry-run    Show what would be done without making changes"
	echo "  --list       List available steps"
	echo "  -h, --help   Show this help"
	echo ""
	echo -e "${BOLD}Steps:${RESET}"
	for step in "${STEPS[@]}"; do
		echo "  $step"
	done
	echo ""
	echo "Run without a step to execute all steps in order."
	echo ""
	echo -e "${BOLD}Examples:${RESET}"
	echo "  ./setup.sh                  # Run all steps"
	echo "  ./setup.sh packages         # Install packages only"
	echo "  ./setup.sh --dry-run        # Preview all steps"
	echo "  ./setup.sh --dry-run symlinks  # Preview symlinks only"
}

function _run_step {
	local step="$1"
	echo ""
	echo -e "${BOLD}===============================${RESET}"
	echo -e "${BOLD}==> $step${RESET}"
	echo -e "${BOLD}===============================${RESET}"
	"$step"
}

# --- Parse args ---
STEP=""
for arg in "$@"; do
	case "$arg" in
		--dry-run) export DRY_RUN=1 ;;
		--list) printf '%s\n' "${STEPS[@]}"; exit 0 ;;
		-h|--help) usage; exit 0 ;;
		*)
			if declare -f "$arg" > /dev/null; then
				STEP="$arg"
			else
				echo -e "${RED}Unknown step:${RESET} $arg"
				usage
				exit 1
			fi
			;;
	esac
done

# --- Sudo upfront ---
if [[ "$DRY_RUN" != "1" ]]; then
	echo -e "${BOLD}This script requires sudo for some steps.${RESET}"
	sudo -v
	# Keep sudo alive in the background
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

if [[ "$DRY_RUN" == "1" ]]; then
	echo -e "${YELLOW}${BOLD}=== DRY RUN ===${RESET}"
fi

# --- Execute ---
chmod -R +x "$DOTFILES_DIR/scripts" 2>/dev/null || true
chmod -R +x "$DOTFILES_DIR/install" 2>/dev/null || true

if [[ -n "$STEP" ]]; then
	_run_step "$STEP"
else
	for step in "${STEPS[@]}"; do
		_run_step "$step"
	done

	echo ""
	echo -e "${GREEN}${BOLD}==> Setup complete!${RESET}"

	if [[ "$DRY_RUN" != "1" ]]; then
		figlet "Welcome" | lolcat && figlet "Back $USER" | lolcat
		read -n 1 -p "Press any key to reboot..." _
		sudo systemctl enable sddm
		reboot
	fi
fi
