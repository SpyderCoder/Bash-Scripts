#!/bin/bash

on_main=$(xrandr --listactivemonitors | grep -c "Monitors: 2")

# Clears any additional prompts before making another one
pkill kdialog

if [ $on_main -eq 1 ]; then
    kdialog --title "Theatre Toggle" --warningyesno "Do you want to switch\
 to Theatre mode?"
    if [ $? = 0 ]; then
        xdotool mousemove 1700 1050 click 1 mousemove 1700 870 click 1
        flatpak run tv.kodi.Kodi
    fi
else
    kdialog --title "Theatre Toggle" --warningyesno "Do you want to switch\
 to Desktop mode?"
    if [ $? = 0 ]; then
        flatpak kill tv.kodi.Kodi
        sleep 1
        xdotool mousemove 3600 2130 click 1 mousemove 3600 1910 click 1
    fi
fi
