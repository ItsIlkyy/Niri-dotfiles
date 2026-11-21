#!/bin/sh
set_wallpaper_hyprland() {
    dir="${HOME}/.config/walls"
    BG="$(find -L "$dir" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | shuf -n1)"
    trans_type="grow"

    if [ -z "$BG" ]; then
        echo "No wallpapers found in $dir" >&2
        return 1
    fi

    if ! pgrep -x "awww-daemon" >/dev/null; then
        awww-daemon &
        sleep 0.5
    fi

    awww img "$BG" --transition-fps 240 --transition-type "$trans_type" --transition-duration 1.5
}
set_wallpaper_hyprland
