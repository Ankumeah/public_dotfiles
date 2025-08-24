#!/bin/env bash  
  
window_pids=$(hyprctl clients -j | jq -r '.[] | select(.workspace.name == "11") | .pid')  
active_workspace=$(hyprctl activeworkspace -j | jq -r ".id")  
  
if [ -z $window_pids ]; then
  hyprctl dispatch exec $1
else
  for pid in $window_pids; do  
    hyprctl dispatch movetoworkspacesilent "$active_workspace,pid:$pid"  
    break
  done  
fi
  
hyprctl dispatch exec "[workspace 11 silent] $1"
