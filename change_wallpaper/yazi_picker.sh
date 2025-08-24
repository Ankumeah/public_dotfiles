#!/bin/bash

tmpfile=$(mktemp /tmp/yazi-pick.XXXXXX)

yazi ~/Pictures/Wallpaper/ --chooser-file="$tmpfile"

if [[ -s "$tmpfile" ]]; then
  pick=$(<"$tmpfile")
  case "${pick,,}" in
  *.png | *.jpg | *.jpeg)
    notify-send -a "Wallpaper" -i $pick $pick
    $(dirname "$0")/change_wallpaper.sh $pick
    ;;
  *)
    notify-send "Wallpaper" "Not a supported file type"
    ;;
  esac
else
  notify-send "Wallpaper" "No file selected."
fi

rm -f "$tmpfile"
