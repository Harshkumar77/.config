#!/bin/zsh
mode="$(~/.config/ts-scripts/key.ts screenshotMode)"

if [ "$mode" = "window" ]; then
  wid="$(xdotool getactivewindow)"
  maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png
  notify-send "clipboard screenshot $(xdotool getwindowname "$wid" | tr ' /' '__')"
else
  maim | xclip -selection clipboard -t image/png -i
  notify-send "clipboard screenshot full"
fi
