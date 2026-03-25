#!/bin/bash

if [ -z $@ ]
then
  layouts=(
      "~/Electra Coil/Raw/"
  )
  printf "%s\n" "${layouts[@]}" 
else
LAYOUT="$1"
  notify-send "$LAYOUT"

  thunar "$1"
fi

