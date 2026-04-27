#!/bin/zsh

mode="$(~/.config/ts-scripts/key.ts screenshotMode)"

if [ "$mode" = "window" ]; then
  wid="$(xdotool getactivewindow)"
  maim -i "$wid" ~/Pictures/"$(date +'%Y-%m-%d_%H-%M-%S')-$(xdotool getwindowname "$wid" | tr ' /' '__').png"
  notify-send "screenshot window $(date)"
else
  maim ~/Pictures/"$(date +'%Y-%m-%d_%H-%M-%S')-fullscreen.png"
  notify-send "screenshot full $(date)"
fi
