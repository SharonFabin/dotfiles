#!/bin/bash
# LICENSE: PUBLIC DOMAIN
# switch between my layouts

# If an explicit layout is provided as an argument, use it. Otherwise, select the next layout from
# the set [us, it, fr].
killall xcape
if [[ -n "$1" ]]; then
    setxkbmap $1
else
	layout=$(setxkbmap -query | awk 'FNR==3{print $2}')
	    case $layout in
		us)
			setxkbmap il -option "altwin:swap_alt_win"
			;;
		*)
			setxkbmap us -option "altwin:swap_alt_win"
			~/dotfiles/arch/scripts/vim_keyboard_bindings.sh
			;;
		esac
fi
