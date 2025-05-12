#!/bin/bash

swww img $1 --transition-type wipe --transition-angle 30 --transition-fps 24 --transition-duration 2

wal -i $1
color7=$(jq -r '.colors.color7' ~/.cache/wal/colors.json)
color7_nopound="${color7:1}"

echo "\$wall_color = rgba(${color7_nopound}ee)" >/home/anku/.config/hypr/colors.conf
hyprctl reload

cat ~/.cache/wal/colors-waybar.css >~/.config/waybar/color.css
if pgrep -x waybar >/dev/null; then
    pkill -USR2 waybar
else
    waybar &
fi
