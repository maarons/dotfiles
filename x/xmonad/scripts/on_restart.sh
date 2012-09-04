#!/bin/bash

stage=$1

run()
{
    if [[ "$stage" = "before" ]]; then
        killall "$1"
    fi
    if [[ "$stage" = "after" ]]; then
        nohup "$@" &> /dev/null &
    fi
}

stop()
{
    if [[ "$stage" = "before" ]]; then
        killall "$1"
    fi
}

run gnome-do
run wicd-client --tray
run bluetooth-applet
run parcellite
run xscreensaver
run kwalletmanager
stop xmobar

if [[ "$stage" = "after" ]]; then
    ~/.xmonad/scripts/setbg.sh
fi
