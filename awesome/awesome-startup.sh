#!/bin/bash

choice=$((
        echo "Yes";
        echo "No"
) | rofi -dmenu -p "Some goodies?")

if [ "$choice" == 'Yes' ]; then
    awesome-client '
      local awful = require("awful")
      awful.spawn.with_shell("~/.config/scripts/backup.sh")
      awful.spawn.with_shell("~/.config/awesome/Long.sh")
      awful.spawn.with_shell("~/.config/awesome/Song.sh")
      awful.spawn.with_shell("android-studio")
    '
fi
