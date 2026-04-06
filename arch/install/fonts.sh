#!/bin/bash

function fonts {
	echo "==> Setting up fonts..."

	if [[ $(id -u) -ne 0 ]]; then
		echo "Font config requires root. Running with sudo..."
	fi

	sudo pacman -S --needed --noconfirm noto-fonts-emoji

	sudo tee /etc/fonts/local.conf > /dev/null <<'FONTCONF'
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

	fc-cache -f
	echo "Font setup complete."
}
