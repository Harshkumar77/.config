#!/bin/bash

# Define available layouts
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

# Use rofi to select a layout
selected_layout=$(printf "%s\n" "${layouts[@]}" | rofi -dmenu -e "Select Layout:")

# Output the selected layout
echo "$selected_layout"
