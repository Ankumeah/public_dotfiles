#! /bin/bash

swww img $1 --transition-type wipe --transition-angle 30 --transition-fps 24 --transition-duration 2 &
wal -i $1

for sock in "$XDG_RUNTIME_DIR"/nvim.*.0; do
  if [[ -S "$sock" ]]; then
    nvim --server "$sock" --remote-send ':colorscheme quite<CR>' &
    nvim --server "$sock" --remote-send ':colorscheme pywal<CR>' &
  fi
done

color2=$(jq -r '.colors.color2' ~/.cache/wal/colors.json)
color2_nopound="${color2:1}"
echo "\$wall_color = rgba(${color2_nopound}ee)" > ~/.config/hypr/hyprland/colors.conf
hyprctl reload &

echo "\$wallpaper = $1
\$accent = rgba(${color2_nopound}ee)
" >~/.config/hypr/hyprlock_wallpapaer.conf

cat ~/.cache/wal/colors.scss > ~/.config/eww/colors.scss
eww reload --config ~/.config/eww/bar/ &

cat ~/.cache/wal/colors-mako > ~/.config/mako/config
makoctl reload &

pywalfox update &

wait
