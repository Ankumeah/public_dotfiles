#!/bin/bash

last_state="open"
while true; do
  lid_state=$(cat /proc/acpi/button/lid/LID0/state | grep -o 'closed\|open')
  if [ "$lid_state" != "$last_state" ]; then
    if [ "$lid_state" == "closed" ]; then
      playerctl pause -a &
      hyprlock &
      sleep 0.2
      hyprctl dispatch dpms off
    elif [ "$lid_state" == "open" ]; then
      hyprctl dispatch dpms on
    fi
    last_state=$lid_state
  fi
  sleep 0.1
done
