#!/bin/bash

p=$
      (
        (
            cat ~/.config/alias.zsh | rg --fixed-strings "() {" -A 0 -B 0 | xargs -I{} node -p "'{}'.split('(')[0]";

            cat ~/.config/alias.zsh | rg --fixed-strings "alias" | xargs -I{} node -p "'{}'.split(' ')[1].split('=')[0]"

        ) | xargs -I{} "source ~/.config/alias.zsh; {}" > /tmp/r/"{}".zsh
      )

notify-send $p

