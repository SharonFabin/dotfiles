sudo systemctl enable wakelock@sharon
sudo systemctl disable lightdm.service
sudo systemctl enable sddm.service
sudo systemctl enable --now cronie
sudo systemctl enable --now bluetooth
sudo systemctl enable --now docker
sudo systemctl --user enable --now pipewire.service
sudo systemctl --user enable --now pipwire-pulse.service
sudo usermod -aG docker $USER
