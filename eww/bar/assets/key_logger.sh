#! /bin/env bash

tmpFile=$(mktemp /tmp/eww_image_switch.XXXXX)

libinput debug-events | grep --line-buffered pressed >"$tmpFile" &

flag=1

while inotifywait -qqe modify "$tmpFile"; do
  flag=$((3-$flag))

  eww update --config ~/.config/eww/bar/ image_switch=$flag

  : >"$tmpFile"
done
