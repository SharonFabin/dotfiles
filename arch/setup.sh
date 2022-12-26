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
./setup-pictures.sh

# Setup Theme
sudo mv /usr/share/themes/Sweet-cursors /usr/share/icons/Sweet-cursors

# Finishing Notes
echo "Things to setup:"
echo "1. If you have bluetooth problems (particulary A2DP profile problem), downgrade bluez to 1.58 with pamac install downgrade"
echo "2. font fallback - hebrew - can be found in dotfiles in fonts folder and needs to be updated at /etc/fonts/conf.d/65-nonlatin.conf"
echo "setup theme and icons with lxappearance"
echo "3. setup cron jobs from ~/dotfiles/arch/cron/ to ~/var/spool/cron/"
echo "4. setup sddm theme with sddm-config-editor, setup sddm login background - background are kept in /usr/share/sddm/themes/sugar-candy/Backgrounds and the background config can be found at /usr/share/sddm/themes/sugar-candy/theme.conf"
echo "5. setup backups with timeshift-gtk"
echo "6. sound problem - install sof-firmware"
echo "7. mouse lag problem - add to /etc/default/grub in default parameters: usbcore.autosuspend=0"
echo "8. setup firewall with gufw"

figlet "Welcome" | lolcat && figlet "Back $USER" | lolcat
read  -n 1 -p "Please Press any key to reboot, run post-install script after reboot!" mainmenuinput
sudo systemctl enable sddm
reboot
