#!/usr/bin/env bash

if [ $(hyprctl getoption general:layout | head -n1 | cut -d " " -f2) = "dwindle" ]; then
    hyprctl keyword general:layout "master"
else
    hyprctl keyword general:layout "dwindle"
fi
