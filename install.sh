#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { printf "${CYAN}==>${NC} %s\n" "$1"; }
ok()    { printf "${GREEN}  [OK]${NC} %s\n" "$1"; }
warn()  { printf "${YELLOW}  [!]${NC} %s\n" "$1"; }
err()   { printf "${RED}  [ERR]${NC} %s\n" "$1" >&2; }

if [ "$EUID" -eq 0 ]; then
    err "Do not run this script as root. Run as your normal user (sudo will be prompted when needed)."
    exit 1
fi

PACMAN_PKGS=(
    # Display manager, Wayland compositor & core utilities
    ly niri waybar tofi mako swayosd hyprlock hypridle xwayland-satellite
    xdg-desktop-portal-gnome polkit-gnome wl-clipboard brightnessctl
    # Terminal, shell & editor
    kitty fish neovim stow git base-devel
    # File managers, media & system tools
    yazi mpv cava bottom fastfetch zathura zathura-pdf-mupdf
    # Audio & Bluetooth
    pipewire pipewire-pulse pipewire-alsa wireplumber bluez bluez-utils
    # Power management & theming
    tuned powertop acpi gtk3 gtk4 nwg-look xsettingsd
    ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji
)

AUR_PKGS=(
    librewolf-bin
    nordend
    awww
    nordic-theme
)

install_pacman_packages() {
    info "Updating system and installing official Arch packages..."
    sudo pacman -Syu --needed --noconfirm "${PACMAN_PKGS[@]}"
    ok "Official packages installed."
}

install_aur_helper() {
    if command -v paru >/dev/null 2>&1; then
        AUR_HELPER="paru"
    elif command -v yay >/dev/null 2>&1; then
        AUR_HELPER="yay"
    else
        info "Installing paru AUR helper..."
        local tmpdir
        tmpdir="$(mktemp -d)"
        git clone https://aur.archlinux.org/paru-bin.git "$tmpdir/paru-bin"
        (cd "$tmpdir/paru-bin" && makepkg -si --noconfirm)
        rm -rf "$tmpdir"
        AUR_HELPER="paru"
    fi
    ok "Using AUR helper: $AUR_HELPER"
}

install_aur_packages() {
    info "Installing AUR packages..."
    "$AUR_HELPER" -S --needed --noconfirm "${AUR_PKGS[@]}"
    ok "AUR packages installed."
}

stow_dotfiles() {
    info "Symlinking dotfiles via GNU Stow..."
    cd "$DOTFILES_DIR"

    local backup_dir="${HOME}/.config-backup-$(date +%Y%m%d-%H%M%S)"
    local backed_up=0

    for pkg in */; do
        pkg="${pkg%/}"
        case "$pkg" in
            screenshots|assets|docs|.git) continue ;;
        esac

        while IFS= read -r -d '' file; do
            rel="${file#"$pkg"/}"
            target="${HOME}/${rel}"
            if [ -e "$target" ] && [ ! -L "$target" ]; then
                mkdir -p "$backup_dir/$(dirname "$rel")"
                mv "$target" "$backup_dir/$rel"
                backed_up=1
            fi
        done < <(find "$pkg" -type f -print0)

        stow -R "$pkg"
        ok "Stowed $pkg"
    done

    if [ "$backed_up" -eq 1 ]; then
        warn "Backed up pre-existing configs to $backup_dir"
    fi
}

setup_librewolf_css() {
    info "Checking LibreWolf userChrome.css..."
    if [ -f "$DOTFILES_DIR/librewolf/userChrome.css" ]; then
        local profile_dir
        profile_dir="$(find "${HOME}/.librewolf" -maxdepth 1 -type d -name "*.default*" 2>/dev/null | head -n1 || true)"
        if [ -n "$profile_dir" ]; then
            mkdir -p "$profile_dir/chrome"
            ln -sf "$DOTFILES_DIR/librewolf/userChrome.css" "$profile_dir/chrome/userChrome.css"
            ok "Linked userChrome.css into $profile_dir/chrome/"
        else
            warn "No LibreWolf profile found yet. Launch LibreWolf once, then re-run ./install.sh to link userChrome.css."
        fi
    fi
}

setup_ly_nord() {
    info "Configuring Nord theme for ly..."
    sudo tee /etc/ly/startup.sh > /dev/null << 'EOF'
#!/bin/sh
printf '\033]P02E3440\033]P1BF616A\033]P2A3BE8C\033]P3EBCB8B\033]P481A1C1\033]P5B48EAD\033]P688C0D0\033]P7E5E9F0\033]P84C566A\033]P9BF616A\033]PAA3BE8C\033]PBEBCB8B\033]PC81A1C1\033]PDB48EAD\033]PE8FBCBB\033]PFECEFF4'
clear
EOF
    sudo chmod +x /etc/ly/startup.sh

    if [ -f /etc/ly/config.ini ]; then
        sudo sed -i \
            -e 's|^animation =.*|animation = none|' \
            -e 's|^bg =.*|bg = 0x002E3440|' \
            -e 's|^fg =.*|fg = 0x00ECEFF4|' \
            -e 's|^border_fg =.*|border_fg = 0x0088C0D0|' \
            -e 's|^error_bg =.*|error_bg = 0x002E3440|' \
            -e 's|^error_fg =.*|error_fg = 0x01BF616A|' \
            -e 's|^hide_key_hints =.*|hide_key_hints = true|' \
            -e 's|^hide_version_string =.*|hide_version_string = true|' \
            -e 's|^text_in_center =.*|text_in_center = true|' \
            /etc/ly/config.ini
    fi
    ok "ly Nord theme configured."
}

setup_services_and_power() {
    info "Enabling system services (tuned, bluetooth, ly)..."
    sudo systemctl enable --now tuned.service
    sudo tuned-adm profile powersave || true
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable ly.service

    sudo tee /etc/systemd/system/powertop.service > /dev/null << 'EOF'
[Unit]
Description=PowerTOP auto-tune

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/powertop --auto-tune

[Install]
WantedBy=multi-user.target
EOF
    sudo systemctl daemon-reload
    sudo systemctl enable --now powertop.service
    ok "Power and system services configured."
}

set_default_shell() {
    local fish_path
    fish_path="$(command -v fish)"
    if [ "$SHELL" != "$fish_path" ]; then
        info "Setting default login shell to fish..."
        chsh -s "$fish_path"
        ok "Default shell changed to $fish_path"
    fi
}

main() {
    install_pacman_packages
    install_aur_helper
    install_aur_packages
    stow_dotfiles
    setup_librewolf_css
    setup_ly_nord
    setup_services_and_power
    set_default_shell

    printf "\n${GREEN}Installation complete!${NC} Reboot to start ly and your Nord Niri environment.\n"
}

main "$@"
