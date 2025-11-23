#! /bin/env bash

if [[ -n $1 ]]; then
  hyprctl dispatch workspace 12
  hyprctl dispatch workspace $1
else 
  echo "\$1 was empty"
fi
