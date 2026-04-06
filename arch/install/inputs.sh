#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

function inputs {
	echo "==> Setting up input config..."
	sudo cp "$DOTFILES_DIR/readonly-configs/50-custominputs.conf" /etc/X11/xorg.conf.d/50-custominputs.conf
}
