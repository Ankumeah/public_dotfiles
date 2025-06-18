#!/bin/bash

swww img $1 --transition-type wipe --transition-angle 30 --transition-fps 24 --transition-duration 2
notify-send "Wallpaper" "$1"
/home/anku/.local/bin/wal -i $1
color2=$(jq -r '.colors.color2' ~/.cache/wal/colors.json)
color2_nopound="${color2:1}"

echo "\$wall_color = rgba(${color2_nopound}ee)" >/home/anku/.config/hypr/hyprland/colors.conf
hyprctl reload

cat ~/.cache/wal/colors.scss >~/.config/eww/color.scss
