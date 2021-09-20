# Config

ln -s ~/dotfiles/arch/.profile ~/.profile
ln -s ~/dotfiles/arch/.config/fish ~/.config/fish
ln -s ~/dotfiles/arch/.config/xmobar ~/.config/xmobar
ln -s ~/dotfiles/arch/.config/alacritty ~/.config/alacritty
ln -s ~/dotfiles/arch/.config/picom ~/.config/picom
ln -s ~/dotfiles/arch/.config/rofi ~/.config/rofi
ln -s ~/dotfiles/arch/.config/dunst ~/.config/dunst
ln -s ~/dotfiles/arch/.config/neofetch ~/.config/neofetch
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/arch/fonts ~/.local/share/fonts
fc-cache -fv

# Bash
rm ~/.bash_profile
ln -s ~/dotfiles/arch/.bash_profile ~/.bash_profile

# SpaceVim
ln ~/dotfiles/arch/SpaceVim/autoload ~/.SpaceVim.d/autoload

rm ~/.SpaceVim.d/init.toml
ln ~/dotfiles/arch/SpaceVim/init.toml ~/.SpaceVim.d/init.toml

rm ~/.vim/vimrc
ln ~/dotfiles/arch/SpaceVim/vimrc ~/.vim/vimrc

# XMonad
mkdir ~/.xmonad
ln -s ~/dotfiles/arch/.xmonad/xmonad.hs ~/.xmonad/xmonad.hs

# Systemd
sudo ln -s ~/dotfiles/arch/systemd-services/wakelock@sharon.service /etc/systemd/system/wakelock@sharon.service
