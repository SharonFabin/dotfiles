
# Firefox Theme
git clone https://github.com/manilarome/blurredfox.git
cd blurredfox
./install.sh
cd ..
rm -rf blurredfox

# SpaceVim
curl -sLf https://spacevim.org/install.sh | bash
vim &
sleep 2
killall vim

# SpaceVim
ln -s ~/dotfiles/arch/SpaceVim/autoload ~/.SpaceVim.d/autoload

rm ~/.SpaceVim.d/init.toml
ln -s ~/dotfiles/arch/SpaceVim/init.toml ~/.SpaceVim.d/init.toml

rm ~/.vim/vimrc
ln -s ~/dotfiles/arch/SpaceVim/vimrc ~/.vim/vimrc

sudo aura -S --noconfirm gvim
sudo aura -A whatsapp-nativefier
sudo aura snap install spotify
