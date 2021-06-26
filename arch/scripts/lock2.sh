#!/bin/bash

revert() {
  rm /tmp/*screen*.png
  xset dpms 0 0 0
}

trap revert HUP INT TERM
scrot /tmp/locking_screen.png --silent
convert -scale 10% -scale 1000% /tmp/locking_screen.png /tmp/screen_blur.png
convert -composite /tmp/screen_blur.png ~/Pictures/rick_and_morty_lock_shade.png -gravity South -geometry -20x1200 /tmp/screen.png
i3lock -u -i /tmp/screen.png
revert
