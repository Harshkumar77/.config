#!/bin/bash

if [ -z $@ ]
then
  layouts=(
      "floating"
      "tile"
      "tile.left"
      "tile.bottom"
      "tile.top"
      "fair"
      "fair.horizontal"
      "spiral"
      "spiral.dwindle"
      "max"
      "max.fullscreen"
      "magnifier"
      "corner.nw"
      "corner.ne"
      "corner.sw"
      "corner.se"
  )
  printf "%s\n" "${layouts[@]}" 
else
LAYOUT="$1"
  notify-send "$LAYOUT"

awesome-client "
    local awful = require('awful')

    local layouts = {
      ['floating'] = awful.layout.suit.floating,
      ['tile'] = awful.layout.suit.tile,
      ['tile.left'] = awful.layout.suit.tile.left,
      ['tile.bottom'] = awful.layout.suit.tile.bottom,
      ['tile.top'] = awful.layout.suit.tile.top,
      ['fair'] = awful.layout.suit.fair,
      ['fair.horizontal'] = awful.layout.suit.fair.horizontal,
      ['spiral'] = awful.layout.suit.spiral,
      ['spiral.dwindle'] = awful.layout.suit.spiral.dwindle,
      ['max'] = awful.layout.suit.max,
      ['max.fullscreen'] = awful.layout.suit.max.fullscreen,
      ['magnifier'] = awful.layout.suit.magnifier,
      ['corner.nw'] = awful.layout.suit.corner.nw,
      ['corner.ne'] = awful.layout.suit.corner.ne,
      ['corner.sw'] = awful.layout.suit.corner.sw,
      ['corner.se'] = awful.layout.suit.corner.se,
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
