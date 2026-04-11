#!/bin/zsh



if [ -z $@ ]
then
  node ~/.config/scripts/scrap-alias.js
else
    LAYOUT="$1"
    notify-send "$LAYOUT"
    alacritty --command zsh -c "source ~/.config/alias.zsh; $LAYOUT" >/dev/null 2>&1 &!
fi


