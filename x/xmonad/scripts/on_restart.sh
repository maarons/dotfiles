#!/bin/bash

stage=$1

run()
{
    if [[ "$stage" = "before" ]]; then
        killall "$1"
    fi
    if [[ "$stage" = "after" ]]; then
        nohup "$1" &> /dev/null &
    fi
}

stop()
{
    if [[ "$stage" = "before" ]]; then
        killall "$1"
    fi
}

run gnome-do
run nm-applet
run bluetooth-applet
run parcellite
run xscreensaver
run tint2
run kwalletmanager
stop xmobar

if [[ "$stage" = "after" ]]; then
    ~/.xmonad/scripts/setbg.sh
fi
