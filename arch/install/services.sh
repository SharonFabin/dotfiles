#!/bin/bash

function _enable_service {
	local svc="$1"
	local flags="${2:---now}"

	if systemctl is-enabled "$svc" &>/dev/null; then
		echo -e "  ${GREEN}Already enabled:${RESET} $svc"
		return
	fi

	if [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would enable:${RESET} $svc"
		return
	fi

	echo -e "  ${BLUE}Enabling:${RESET} $svc"
	sudo systemctl enable $flags "$svc"
}

function _enable_user_service {
	local svc="$1"

	if systemctl --user is-enabled "$svc" &>/dev/null; then
		echo -e "  ${GREEN}Already enabled:${RESET} $svc (user)"
		return
	fi

	if [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would enable:${RESET} $svc (user)"
		return
	fi

	echo -e "  ${BLUE}Enabling:${RESET} $svc (user)"
	systemctl --user enable --now "$svc"
}

function services {
	echo -e "${BOLD}[display manager]${RESET}"
	# Disable lightdm if present
	if systemctl is-enabled lightdm.service &>/dev/null; then
		if [[ "$DRY_RUN" != "1" ]]; then
			echo -e "  ${BLUE}Disabling:${RESET} lightdm"
			sudo systemctl disable lightdm.service
		else
			echo -e "  ${YELLOW}Would disable:${RESET} lightdm"
		fi
	fi
	_enable_service sddm.service ""

	echo -e "\n${BOLD}[system services]${RESET}"
	_enable_service cronie
	_enable_service bluetooth
	_enable_service docker
	_enable_service keyd

	echo -e "\n${BOLD}[audio - pipewire]${RESET}"
	# Remove pulseaudio if present
	if pacman -Qi pulseaudio &>/dev/null; then
		if [[ "$DRY_RUN" != "1" ]]; then
			echo -e "  ${BLUE}Removing:${RESET} pulseaudio (replaced by pipewire)"
			sudo pacman -Rdd --noconfirm pulseaudio
		else
			echo -e "  ${YELLOW}Would remove:${RESET} pulseaudio"
		fi
	else
		echo -e "  ${GREEN}Already removed:${RESET} pulseaudio"
	fi
	_enable_user_service pipewire
	_enable_user_service pipewire-pulse

	echo -e "\n${BOLD}[user groups]${RESET}"
	if groups "$USER" | grep -q docker; then
		echo -e "  ${GREEN}Already in group:${RESET} docker"
	elif [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would add to group:${RESET} docker"
	else
		echo -e "  ${BLUE}Adding to group:${RESET} docker"
		sudo usermod -aG docker "$USER"
	fi
}
