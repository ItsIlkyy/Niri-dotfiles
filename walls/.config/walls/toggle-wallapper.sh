#!/bin/sh
set_wallpaper_hyprland() {
    dir="${HOME}/.config/walls"
    BG="$(find "$dir" -name '*.jpg' -o -name '*.png' | shuf -n1)"
    trans_type="grow"

    if ! pgrep -x "awww-daemon" >/dev/null; then
        awww-daemon &
        sleep 0.5
    fi

    awww img "$BG" --transition-fps 240 --transition-type $trans_type --transition-duration 1.5
}
set_wallpaper_hyprland
