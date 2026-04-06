#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Give execute permissions
chmod -R +x "$SCRIPT_DIR/scripts"
chmod -R +x "$SCRIPT_DIR/install"

# Source all modules
for module in "$SCRIPT_DIR"/install/*.sh; do
	source "$module"
done

STEPS=(packages symlinks services fonts inputs wallpapers post)

function usage {
	echo "Usage: ./setup.sh [step]"
	echo ""
	echo "Steps: ${STEPS[*]}"
	echo ""
	echo "Run without arguments to execute all steps."
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	usage
	exit 0
fi

if [[ -n "$1" ]]; then
	if declare -f "$1" > /dev/null; then
		echo "==> Running step: $1"
		"$1"
	else
		echo "Unknown step: $1"
		usage
		exit 1
	fi
else
	for step in "${STEPS[@]}"; do
		echo ""
		echo "==============================="
		echo "==> Running step: $step"
		echo "==============================="
		"$step"
	done

	echo ""
	echo "==============================="
	echo "==> Setup complete!"
	echo "==============================="
	figlet "Welcome" | lolcat && figlet "Back $USER" | lolcat
	read -n 1 -p "Press any key to reboot..." _
	sudo systemctl enable sddm
	reboot
fi
