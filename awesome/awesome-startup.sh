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

if [ "$choice" == "yes" ]; then
  awesome-client 'awful=require("awful");
      awful.spawn("~/.config/awesome/Long.sh", {
        tag       = "fullscreen",
      })'
  # zsh -c '' &
  ~/.config/awesome/Song.sh &
  android-studio &
  anki &
fi
