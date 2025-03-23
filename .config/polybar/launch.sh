#!/usr/bin/env bash

THEME="dracula"

killall polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

CONFIG_DIR=$HOME/.config/polybar/themes/$THEME/config.ini
polybar main -c $CONFIG_DIR &
