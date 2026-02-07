#! /bin/bash

swww img $1 --transition-type wipe --transition-angle 30 --transition-fps 24 --transition-duration 2 &
wal -i $1

for sock in "$XDG_RUNTIME_DIR"/nvim.*.0; do
  if [[ -S "$sock" ]]; then
    nvim --server "$sock" --remote-send ':colorscheme quite<CR>' &
    nvim --server "$sock" --remote-send ':colorscheme pywal<CR>' &
  fi
done

cat ~/.cache/wal/colors.scss > ~/.config/eww/colors.scss
eww reload --config ~/.config/eww/bar/ &

cat ~/.cache/wal/colors-mako > ~/.config/mako/config
makoctl reload &

pywalfox update &

wait
