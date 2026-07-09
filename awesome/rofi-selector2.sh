#!/bin/bash

if [ -z $@ ]
then
  layouts=(
      "layout.floating"
      "layout.tile"
      "layout.tile.left"
      "layout.tile.bottom"
      "layout.tile.top"
      "layout.fair"
      "layout.fair.horizontal"
      "layout.spiral"
      "layout.spiral.dwindle"
      "layout.max"
      "layout.max.fullscreen"
      "layout.magnifier"
      "layout.corner.nw"
      "layout.corner.ne"
      "layout.corner.sw"
      "layout.corner.se"
  )
  printf "%s\n" "${layouts[@]}" 
else
LAYOUT="$1"
  notify-send "$LAYOUT"

awesome-client "
    local awful = require('awful')

    local layouts = {
      ['layout.floating'] = awful.layout.suit.floating,
      ['layout.tile'] = awful.layout.suit.tile,
      ['layout.tile.left'] = awful.layout.suit.tile.left,
      ['layout.tile.bottom'] = awful.layout.suit.tile.bottom,
      ['layout.tile.top'] = awful.layout.suit.tile.top,
      ['layout.fair'] = awful.layout.suit.fair,
      ['layout.fair.horizontal'] = awful.layout.suit.fair.horizontal,
      ['layout.spiral'] = awful.layout.suit.spiral,
      ['layout.spiral.dwindle'] = awful.layout.suit.spiral.dwindle,
      ['layout.max'] = awful.layout.suit.max,
      ['layout.max.fullscreen'] = awful.layout.suit.max.fullscreen,
      ['layout.magnifier'] = awful.layout.suit.magnifier,
      ['layout.corner.nw'] = awful.layout.suit.corner.nw,
      ['layout.corner.ne'] = awful.layout.suit.corner.ne,
      ['layout.corner.sw'] = awful.layout.suit.corner.sw,
      ['layout.corner.se'] = awful.layout.suit.corner.se,
    }

    local t = awful.screen.focused().selected_tag
    if t and layouts['$LAYOUT'] then
      awful.layout.set(layouts['$LAYOUT'], t)
    end
  "
fi

# Define available layouts
# selected_layout=$(printf "%s\n" "${layouts[@]}" | rofi -dmenu -e "Select Layout:")

# Output the selected layout
# echo "$selected_layout"
