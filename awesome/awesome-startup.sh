#!/bin/bash
picom
redshift -x
redshift -O 3500
redshift -O 3500
~/.config/scripts/backup.sh &

killall fusuma
fusuma &

choice=$((
        echo "yes";
        echo "no"
) | rofi -dmenu -p "Some goodies?")

if [ "$choice" == "yes" ]; then
  zsh -c '~/.config/awesome/Long.sh' &
  ~/.config/awesome/Song.sh &
  google-chrome-stable 
  # android-studio &
  # anki &
fi
