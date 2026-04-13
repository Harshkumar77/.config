#!/bin/bash
picom
redshift -x
redshift -O 3500
redshift -O 3500
~/.config/scripts/backup.sh &

choice=$((
        echo "yes";
        echo "no"
) | rofi -dmenu -p "Some goodies?")
  notify-send 33

if [ "$choice" == "Yes" ]; then
  zsh -c '~/.config/awesome/Long.sh' &
  notify-send 3
  ~/.config/awesome/Song.sh &
  android-studio &
  anki &
fi
