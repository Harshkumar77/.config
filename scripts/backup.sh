#!/bin/bash

backupTimeRaw='~/.config/tmp/config-backup-timestamp.txt'
backupTime=$(cat "$backupTimeRaw")
echo $backupTime

hasOneHourPassed=`node -e "
            const diff = (
              ( Number(new Date()) - Number(new Date('$backupTime')) ) / (60*60*1000)
            )

            console.log(
                (Math.random() < 0.25 || diff > 1) ? true : false
              )
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


# monthly
monthly_backupTimeRaw='~/.config/tmp/monthly-config-backup-timestamp.txt'
backupTime=$(cat "$monthly_backupTimeRaw")
echo $backupTime

hasOneMonthPassed=`node -e "
            const diff = (
              ( Number(new Date()) - Number(new Date('$backupTime')) ) / (60*60*1000*24*30)
            )

            console.log(
                (Math.random() < 0.25 || diff > 1) ? true : false
              )
            "`
if [[ "$hasOneMonthPassed" = "true" ]]; then
    awesome-client '
       local naughty = require("naughty")
        naughty.notify({
                text = "config: monthly backup completed",
        })'
    # notify-send "config: skipping backup"
    node -p 'new Date()' > "$monthly_backupTimeRaw"
fi

