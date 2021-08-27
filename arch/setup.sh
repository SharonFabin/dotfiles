#!/bin/bash

# Give execute permissions for all scripts
chmod -R +x ./programs
chmod -R +x ./scripts
chmod +x ./symlink.sh
chmod +x ./pamac_install.sh
chmod +x ./install_programs.sh
chmod +x ./setup-systemd-services.sh

./symlink.sh
./pamac_install.sh
./install_programs.sh
./setup-systemd-services.sh

echo "Things to setup:"
echo "1. natural input scrolling"
echo "2. gtk theme with lxappearance"
echo "3. If you have bluetooth problems (particulary A2DP profile problem), downgrade bluez to 1.58 with pamac install downgrade"
echo "4. Check that xmonad.hs was really linked and setup."

figlet "Welcome" | lolcat && figlet "Back $USER" | lolcat
