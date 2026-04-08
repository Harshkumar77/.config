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
                (Math.random() < 0.05) ? true : false
            "`
if [[ "$shouldRareBackup" = "true" ]]; then
    mkdir ~/.config/mpv/scripts/ -p
    curl "https://raw.githubusercontent.com/Idlusen/mpv-ytsub/refs/heads/main/ytsub.lua" > ~/.config/mpv/scripts/ytsub.lua

    # fd . ~/Music -e txt -x zsh -c 'node -p "\"{//}\".split(\"/\").pop()"; echo; cat {} ;echo' > ~/.config/media/music.txt

    # wallpaper generator

    rm ~/.config/wallpaper/gen/ -rf
    mkdir ~/.config/wallpaper/gen/ --parents     
    mc=$(node -p "\`$(fd . ~/.config/wallpaper/ --max-depth=1 -e png -e jpg -e webp -e jpeg | shuf; fd . ~/.config/wallpaper/ --max-depth=1 -e png -e jpg -e webp -e jpeg)\`
      .split('\n')
      .reduce((acc, cur, i) => {
          if (i % 6 === 0) acc.push([]);
          acc[acc.length - 1].push('\"' + cur + '\"');
          return acc;
        }, [])
      .map((x , i) => \`
        montage \${x.join(' ')} \
         -tile 2x3 \
         -geometry 512x512\>+0+0 \
         -background black \
         -gravity center \
         ~/.config/wallpaper/gen/outputR\${i}.png
        \`)
      .join('\n\n')
    ")
    zsh -c "$mc"


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
