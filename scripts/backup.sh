#!/bin/bash

backupTimeRaw='/tmp/config-backup-timestamp.txt'
backupTime=$(cat "$backupTimeRaw")
echo $backupTime

hasOneHourPassed=`node -e "
            const diff = (Number(new Date()) - Number(new Date('$backupTime')))/(60*60*1000);

            if(Math.random() < 0.25) {
              // edge scenario in case file is missing pass through luck
              console.log(true)
              process.exit()
            }


            console.log(diff > 1 ? true : false);
            "`
if [[ "$hasOneHourPassed" = "false" ]]; then
    awesome-client '
       local naughty = require("naughty")
        naughty.notify({
                text = "config: skipping backup",
        })'
    # notify-send "config: skipping backup"
    exit
fi

cd ~/.config

yay -Qmq > ~/.config/pkgs/aur.txt
yay -Qnq > ~/.config/pkgs/repo.txt

git add wallpaper
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

node -p 'new Date()' > "$backupTimeRaw"
