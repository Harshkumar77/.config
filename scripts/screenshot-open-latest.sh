#!/bin/zsh
 xdg-open "$(ls -t ~/Pictures | head -n 1 | sed "s|^|$HOME/Pictures/|")"
