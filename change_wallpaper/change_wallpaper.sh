#!/bin/bash

# change wallpaper with swww
swww img $1 --transition-type wipe --transition-angle 30 --transition-fps 24 --transition-duration 2

# make color scheme with pywal
wal -i $1

# sync nvim if running
for sock in "$XDG_RUNTIME_DIR"/nvim.*.0; do
  if [[ -S "$sock" ]]; then
    nvim --server "$sock" --remote-send ':lua require("pywal").setup()<CR>'
    nvim --server "$sock" --remote-send ':lua require("lualine").setup()<CR>'
  fi
done

# change border colors on hyprland
color2=$(jq -r '.colors.color2' ~/.cache/wal/colors.json)
color2_nopound="${color2:1}"
echo "\$wall_color = rgba(${color2_nopound}ee)" > ~/.config/hypr/hyprland/colors.conf
hyprctl reload

echo "\$wallpaper = $1
\$accent = rgba(${color2_nopound}ee)
" >~/.config/hypr/hyprlock_wallpapaer.conf

# copy color scheme to eww and reload (eww appends ./ to the front of its imports)
cat ~/.cache/wal/colors.scss > ~/.config/eww/colors.scss
eww reload --config ~/.config/eww/bar/

# copy color scheme to mako
cat ~/.cache/wal/colors-mako > ~/.config/mako/config
makoctl reload

# reload pywalfox
pywalfox update
