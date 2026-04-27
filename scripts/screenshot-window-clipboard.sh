#!/bin/zsh
mode="$(~/.config/ts-scripts/key.ts screenshotMode)"

if [ "$mode" = "window" ]; then
  maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png
  notify-send "screenshot window $(date)"
else
  maim | xclip -selection clipboard -t image/png
  notify-send "screenshot full $(date)"
fi
