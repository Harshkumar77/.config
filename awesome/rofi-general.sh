#!/bin/bash

rofi -p "jkkk" \
  -modes combi \
  -show combi \
  -combi-modes \
  window,custom:~/.config/scripts/all-rofi.sh,drun,layout:~/.config/awesome/rofi-selector2.sh,power-menu:rofi-power-menu,run

