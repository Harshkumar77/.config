#!/bin/bash
awesome-client 'return mouse.screen.selected_tag.layout.name' | awk -F'"' '{printf $2}'

printf " " 
printf 3

