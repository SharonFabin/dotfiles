# Dotfiles

## Setup (Arch Linux)

```bash
git clone <this-repo> ~/dotfiles
cd ~/dotfiles/arch
./setup.sh
```

### Run a single step

```bash
./setup.sh packages    # Install packages (yay, pacman, snap)
./setup.sh symlinks    # Stow configs + manual symlinks
./setup.sh services    # Enable systemd services
./setup.sh fonts       # Set up emoji/font fallbacks
./setup.sh inputs      # Copy Xorg input config
./setup.sh wallpapers  # Clone wallpapers repo
./setup.sh post        # Firefox theme, cursor fix, manual step checklist
```

## Structure

```
dotfiles/
  arch/
    .config/          # App configs (stowed to ~/.config)
    install/          # Modular setup scripts
    scripts/          # User scripts (stowed to ~/.local/bin)
    cron/             # Crontab backups
    fonts/            # Custom fonts
    modules/          # Network configs (wifi)
    readonly-configs/ # System configs (/etc)
    systemd-services/ # Custom systemd units
    setup.sh          # Single entry point
  chrome/             # Browser (Vimium) config
  windows/            # Windows Terminal + AHK config
```
