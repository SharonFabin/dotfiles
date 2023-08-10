# Config

ln -s ~/dotfiles/arch/.config/fish ~/.config/fish
ln -s ~/dotfiles/arch/.config/xmobar ~/.config/xmobar
ln -s ~/dotfiles/arch/.config/xmonad ~/.config/xmonad
ln -s ~/dotfiles/arch/.config/hypr ~/.config/hypr
sudo ln -s ~/dotfiles/arch/.config/keyd/default.conf /etc/keyd/default.conf
ln -s ~/dotfiles/arch/.config/alacritty ~/.config/alacritty
ln -s ~/dotfiles/arch/.config/picom ~/.config/picom
ln -s ~/dotfiles/arch/.config/rofi ~/.config/rofi
ln -s ~/dotfiles/arch/.config/eww ~/.config/eww
ln -s ~/dotfiles/arch/.config/dunst ~/.config/dunst
ln -s ~/dotfiles/arch/.config/gtk-3.0 ~/.config/gtk-3.0
ln -s ~/dotfiles/arch/.config/neofetch ~/.config/neofetch
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/arch/fonts ~/.local/share/fonts
fc-cache -fv

# Bash
mv ~/.bash_profile ~/.bash_profile_backup
mv ~/.profile ~/.profile_backup
ln -s ~/dotfiles/arch/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/arch/.profile ~/.profile

# Scripts
mkdir /home/sharon/.local/bin
ln ~/dotfiles/arch/scripts/bin/* ~/.local/bin/

# Systemd
sudo ln -s ~/dotfiles/arch/systemd-services/wakelock@sharon.service /etc/systemd/system/wakelock@sharon.service

# SDDM Theme
sudo mv /usr/share/sddm/themes/sugar-candy/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf_backup
sudo mv /usr/share/sddm/themes/sugar-candy/Backgrounds /usr/share/sddm/themes/sugar-candy/Backgrounds_backup
sudo ln -s ~/dotfiles/arch/.config/sddm/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf
sudo ln -s ~/dotfiles/arch/.config/sddm/Backgrounds /usr/share/sddm/themes/sugar-candy/Backgrounds
sudo ln -s ~/dotfiles/arch/.config/sddm.conf.d /etc/sddm.conf.d
