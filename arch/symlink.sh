# Config
cd ~/dotfiles/arch/
stow -v -t ~/.config .config
sudo ln -s ~/dotfiles/arch/.config/keyd/default.conf /etc/keyd/default.conf

# Bash
#mv ~/.bash_profile ~/.bash_profile_backup
#ln -s ~/dotfiles/arch/.bash_profile ~/.bash_profile
mv ~/.profile ~/.profile_backup
ln -s ~/dotfiles/arch/.profile ~/.profile

# Scripts
mkdir /home/sharon/.local/bin
cd ~/dotfiles/arch/scripts/
stow -v -t ~/.local/bin bin

# Systemd
cd ~/dotfiles/arch/systemd-services/
sudo stow -v -t /etc/systemd/system ~/dotfiles/arch/systemd-services

# SDDM Theme
sudo mv /usr/share/sddm/themes/sugar-candy/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf_backup
sudo mv /usr/share/sddm/themes/sugar-candy/Backgrounds /usr/share/sddm/themes/sugar-candy/Backgrounds_backup
sudo ln -s ~/dotfiles/arch/.config/sddm/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf
sudo ln -s ~/dotfiles/arch/.config/sddm/Backgrounds /usr/share/sddm/themes/sugar-candy/Backgrounds
sudo ln -s ~/dotfiles/arch/.config/sddm.conf.d /etc/sddm.conf.d
