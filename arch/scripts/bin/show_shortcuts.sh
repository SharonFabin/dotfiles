#!/bin/bash

zenity --text-info \
       --title="Keyboard Shortcuts Cheat Sheet" \
       --width=600 \
       --height=400 \
       --filename="keyboard_shortcuts.txt" \
       --font="Ubuntu 10" \
       --ok-label="Close" \
       --cancel-label="Copy to Clipboard" \
       --extra-button="Save as PDF" \
       --window-icon="/usr/share/icons/hicolor/48x48/apps/system-help.png" \
       --icon-name="gnome-settings-panel"

response=$?

case $response in
   0) exit;;  # Close
   1) xclip -sel clip < keyboard_shortcuts.txt;;  # Copy to clipboard
   2) zenity --question --title="Save as PDF" --text="Do you want to save the cheat sheet as a PDF file?" && \
       wkhtmltopdf keyboard_shortcuts.txt keyboard_shortcuts.pdf && \
       zenity --info --title="Save as PDF" --text="The cheat sheet has been saved as 'keyboard_shortcuts.pdf'.";;  # Save as PDF
esac
