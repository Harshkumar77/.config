#!/bin/zsh
# flameshot screen -p ~/Pictures/"$(date +'%Y-%m-%d_%H-%M-%S')-fullscreen.png"

name="$(date +'%Y-%m-%d_%H-%M-%S')-fullscreen.png"
xfce4-screenshooter -f -s ~/Pictures/"$name"
xfce4-screenshooter -c -f &
satty --filename ~/Pictures/"$name" --actions-on-enter save-to-clipboard --actions-on-escape save-to-file -o ~/Pictures/"$name"


