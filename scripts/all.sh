#!/bin/zsh

node -p "
  [
    ...\`$(cat ~/.config/alias.zsh | rg --fixed-strings "() {" -A 0 -B 0)\`
      .split('\n')
      .map(_ => _.split('(')[0]), 

    ...\`$(fd -e sh . ~/.config/)\`
      .split('\n'),

    ].join('\n')" |
rofi -dmenu -multi-select |
xargs -I{} xargs alacritty --command zsh -c "source ~/.config/alias.zsh; {}"
      

