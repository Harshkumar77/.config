#!/bin/bash
cd ~/.config

shouldRegularBackup=`node -p "(Math.random() < 0.40) ? true : false"`

if [[ "$shouldRegularBackup" = "true" ]]; then
    yay -Qmq > ~/.config/pkgs/aur.txt
    yay -Qnq > ~/.config/pkgs/repo.txt

    git add wallpaper
    git add ~/.config/extensions-browser-backup
    git add nvim

    git add -u
    git commit -m "backup $(date)"

    git push

    awesome-client '
     local naughty = require("naughty")
      naughty.notify({
              text = "config: backup done",
      })'
    # notify-send "config: backup done"
fi


# monthly
shouldRareBackup=`node -p "
                (Math.random() < 0.10) ? true : false
            "`
if [[ "$shouldRareBackup" = "true" ]]; then
    mkdir ~/.config/mpv/scripts/ -p
    curl "https://raw.githubusercontent.com/Idlusen/mpv-ytsub/refs/heads/main/ytsub.lua" > ~/.config/mpv/scripts/ytsub.lua
    awesome-client '
       local naughty = require("naughty")
        naughty.notify({
                text = "config: monthly backup completed",
        })'
    echo 'text = "config: monthly backup completed",'
    # notify-send "config: skipping backup"
else
    awesome-client '
       local naughty = require("naughty")
        naughty.notify({
                text = "config: skipping monthly backup",
        })'
    # notify-send "config: skipping backup"
fi
