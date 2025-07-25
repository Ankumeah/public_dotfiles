#! /bin/env bash

tmpFile=$(mktemp /tmp/eww_image_switch.XXXXX)

sudo libinput debug-events | grep --line-buffered pressed >"$tmpFile" &

flag=1

while inotifywait -qqe modify "$tmpFile"; do
  eww update bar_image_switch=$flag
  flag=$((1 - flag))

  : >"$tmpFile"
done
