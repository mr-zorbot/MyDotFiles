#!/usr/bin/env bash

FILE=$1

case $FILE in
  *.jpg | *.jpeg | *.png | *.gif | *.bmp | *.tif \
    | *.tiff | *.webp | *.svg | *.heic | *.heif)
    
    FZF_PREVIEW_COLUMNS=$2
    FZF_PREVIEW_LINES=$3
    
    kitten icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no \
      --place="${FZF_PREVIEW_COLUMNS}x$((FZF_PREVIEW_LINES - 1))@0x0" "$FILE" | sed '$d' | sed $'$s/$/\e[m/'

    ;;
    
  *) 
    bat -f --style=numbers --theme=Dracula $FILE 2>/dev/null
    ;;

esac
