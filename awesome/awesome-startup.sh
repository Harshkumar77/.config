#!/bin/zsh
picom
redshift -x
redshift -O 3500
redshift -O 3500
~/.config/scripts/backup.sh &

choice=$((
        echo "Yes";
        echo "No"
) | rofi -dmenu -p "Some goodies?")

if [ "$choice" == 'Yes' ]; then
  ~/.config/awesome/Long.sh
  ~/.config/awesome/Song.sh
  android-studio
  anki
fi
