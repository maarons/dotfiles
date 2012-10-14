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

run wicd-client --tray
run blueman-applet
run parcellite
run xscreensaver
run kwalletmanager
stop xmobar

if [[ "$stage" = "after" ]]; then
    ~/.xmonad/scripts/setbg.sh
    # Make the arrow cursor default instead of the "X" one.
    xsetroot -cursor_name left_ptr
fi
