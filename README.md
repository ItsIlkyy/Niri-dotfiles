# Nord Niri Dotfiles

Minimal, keyboard-driven Arch Linux desktop configuration built around the **Niri** Wayland compositor and styled with the **Nord** color palette (`#2E3440`, `#88C0D0`, `#ECEFF4`).


## Preview

| Desktop & Waybar | Tofi Launcher |
| :---: | :---: |
| ![Desktop](screenshots/desktop1.png) | ![Launcher](screenshots/launcher.png) |


## Stack Overview

| Component | Tool | Notes |
| :--- | :--- | :--- |
| **Compositor** | [Niri](https://github.com/YaLTeR/niri) | Scrollable-tiling Wayland compositor + native screenshots |
| **Bar** | [Waybar](https://github.com/Alexays/Waybar) | Status bar with `cava` audio visualizer integration |
| **Launcher** | [Tofi](https://github.com/philj56/tofi) | Full-screen, iconless Nord launcher (`tofi-drun`) |
| **Notifications** | [Mako](https://github.com/emersion/mako) | Lightweight Wayland notification daemon |
| **OSD** | [SwayOSD](https://github.com/ErikReider/SwayOSD) | Nord-styled volume, brightness, and lock-key popups |
| **Lock & Idle** | `hyprlock` / `hypridle` | JetBrainsMono Nerd Font clock + Niri DPMS power management |
| **Terminal & Shell** | `kitty` / `fish` | Nord theme with custom aliases and completions |
| **Editor** | [Neovim](https://neovim.io/) | Vanilla Lua config with Nord palette |
| **File Managers** | `nordend` / `yazi` | Native Wayland GUI + terminal file manager |
| **Media & System** | `mpv`, `cava`, `bottom`, `fastfetch` | VA-API hardware-accelerated media & system monitoring |
| **Theming** | `gtk-3.0`, `gtk-4.0`, `nwg-look`, `xsettingsd` | Unified Nord GTK & XWayland appearance |
| **Portals** | `xdg-desktop-portal-gnome` | PipeWire screen sharing without GTK file-picker overrides |

## Repository Structure

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory mirrors `$HOME` (`~`):

```text
dotfiles/
├── bottom/               # System monitor config
├── cava/                 # Audio visualizer config
├── desktop/              # Default application associations (mimeapps.list)
├── fastfetch/            # System fetch layout
├── fish/                 # Fish shell config, aliases, and functions
├── gtk-3.0/              # GTK 3 theme settings
├── gtk-4.0/              # GTK 4 theme settings
├── hypr/                 # hyprlock & hypridle configs
├── kitty/                # Kitty terminal & Nord color scheme
├── mako/                 # Notification daemon styling
├── mpv/                  # Video player settings
├── niri/                 # Niri compositor config & keybinds
├── nordend/              # Nordend file manager config
├── nvim/                 # Neovim Lua configuration
├── nwg-look/             # GTK look settings
├── scripts/              # Custom user scripts (~/.local/bin, battery alerts)
├── swayosd/              # SwayOSD Nord GTK CSS
├── tofi/                 # Tofi launcher config
├── walls/                # Nord wallpapers
├── waybar/               # Waybar layout & CSS
├── xdg-desktop-portal/   # Niri screencast portal routing
├── xsettingsd/           # XWayland theme settings
└── yazi/                 # Terminal file manager config
```

## Installation

### 1. Install Dependencies (Arch Linux)
```fish
sudo pacman -S --needed \
  niri waybar tofi mako swayosd hyprlock hypridle \
  kitty fish neovim yazi mpv cava bottom fastfetch \
  xdg-desktop-portal xdg-desktop-portal-gnome \
  brightnessctl wl-clipboard ttf-jetbrains-mono-nerd \
  stow git
```

### 2. Clone & Symlink with GNU Stow
```fish
git clone [https://github.com/Zomboy01/dotfiles.git](https://github.com/Zomboy01/dotfiles.git) ~/dotfiles
cd ~/dotfiles

# Remove default auto-generated fish config if running inside fish
rm -f ~/.config/fish/config.fish

# Symlink all packages into ~
stow -v */
```

### 3. Enable Background Services
```fish
sudo systemctl enable --now swayosd-libinput-backend.service
```
