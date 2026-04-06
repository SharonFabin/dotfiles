#!/bin/bash

function fonts {
	echo -e "${BOLD}[emoji fonts]${RESET}"

	if pacman -Qi noto-fonts-emoji &>/dev/null; then
		echo -e "  ${GREEN}Already installed:${RESET} noto-fonts-emoji"
	elif [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would install:${RESET} noto-fonts-emoji"
	else
		echo -e "  ${BLUE}Installing:${RESET} noto-fonts-emoji"
		sudo pacman -S --needed --noconfirm noto-fonts-emoji
	fi

	echo -e "\n${BOLD}[font config]${RESET}"
	local fontconf="/etc/fonts/local.conf"

	if [[ -f "$fontconf" ]] && grep -q "Noto Color Emoji" "$fontconf" 2>/dev/null; then
		echo -e "  ${GREEN}Already configured:${RESET} $fontconf"
	elif [[ "$DRY_RUN" == "1" ]]; then
		echo -e "  ${YELLOW}Would write:${RESET} $fontconf"
	else
		echo -e "  ${BLUE}Writing:${RESET} $fontconf"
		sudo tee "$fontconf" > /dev/null <<'FONTCONF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias>
    <family>sans-serif</family>
    <prefer>
      <family>Noto Sans</family>
      <family>Noto Color Emoji</family>
      <family>Noto Emoji</family>
      <family>DejaVu Sans</family>
    </prefer>
  </alias>
  <alias>
    <family>serif</family>
    <prefer>
      <family>Noto Serif</family>
      <family>Noto Color Emoji</family>
      <family>Noto Emoji</family>
      <family>DejaVu Serif</family>
    </prefer>
  </alias>
  <alias>
    <family>monospace</family>
    <prefer>
      <family>Noto Mono</family>
      <family>Noto Color Emoji</family>
      <family>Noto Emoji</family>
      <family>DejaVu Sans Mono</family>
    </prefer>
  </alias>
</fontconfig>
FONTCONF
		echo -e "  ${BLUE}Refreshing:${RESET} font cache"
		fc-cache -f
	fi
}
