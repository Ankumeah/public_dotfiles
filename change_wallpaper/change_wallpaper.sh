#!/bin/bash

# change wallpaper with swww and make color scheme with pywal (installed with pipx)
swww img $1 --transition-type wipe --transition-angle 30 --transition-fps 24 --transition-duration 2
notify-send "Wallpaper" "$1"
~/.local/bin/wal -i $1

# change border colors on hyprland
color2=$(jq -r '.colors.color2' ~/.cache/wal/colors.json)
color2_nopound="${color2:1}"
echo "\$wall_color = rgba(${color2_nopound}ee)" >~/.config/hypr/hyprland/colors.conf
hyprctl reload

# copy colors scheme to eww (eww appends ./ to the front of its imports so use of absalute paths is not supported)
cat ~/.cache/wal/colors.scss >~/.config/eww/colors.scss
