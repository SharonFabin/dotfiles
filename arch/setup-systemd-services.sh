sudo systemctl disable lightdm.service
sudo systemctl enable sddm.service
sudo systemctl enable --now cronie
sudo systemctl enable --now bluetooth
sudo systemctl enable --now docker
sudo systemctl enable --now keyd
sudo pacman -Rdd pulseaudio
sudo pacman -S pipewire-{jack,alsa,pulse}
systemctl --user enable --now pipewire pipewire-pulse
sudo usermod -aG docker $USER
