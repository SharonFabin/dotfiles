#!/bin/bash

# Give execute permissions for all scripts
chmod -R +x ./scripts
chmod +x ./install.sh
chmod +x ./symlink.sh
chmod +x ./setup-systemd-services.sh
chmod +x ./setup-inputs.sh
chmod +x ./setup-pictures.sh

./install.sh
./symlink.sh
./setup-systemd-services.sh
./setup-inputs.sh
./setup-vim.sh
./setup-pictures.sh

# Setup Theme
sudo mv /usr/share/themes/Sweet-cursors /usr/share/icons/Sweet-cursors

# Finishing Notes
echo "Things to setup:"
echo "1. Read-only configs (configs are found in $HOME/dotfiles/arch/readonly-configs):
	* suspend - config location is /etc/systemd/logind.conf
"
echo "2. gtk theme with lxappearance"
echo "3. If you have bluetooth problems (particulary A2DP profile problem), downgrade bluez to 1.58 with pamac install downgrade"
echo "4. vim color scheme - can be found in ~/dotfiles/arch/vim/, need to put in ~/.vim/pack/vendor/start/vim-code-dark"
echo "5. font fallback - hebrew - can be found in dotfiles in fonts folder and needs to be updated at /etc/fonts/conf.d/65-nonlatin.conf"
echo "6. setup cron jobs from ~/dotfiles/arch/cron/ to ~/var/spool/cron/"
echo "7. setup sddm login background - background are kept in /usr/share/sddm/themes/sugar-candy/Backgrounds and the background config can be found at /usr/share/sddm/themes/sugar-candy/theme.conf"
echo "8. setup backgrounds - remember when setting up using nitrogen to use (--head=0) to setup background for first monitor or (--head=n) for the n'th monitor"

figlet "Welcome" | lolcat && figlet "Back $USER" | lolcat
