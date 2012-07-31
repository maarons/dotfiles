#!/bin/bash

# Stop all autostarted programs.
~/.xmonad/scripts/on_restart.sh before

# Will go 100% CPU if not killed.
{
    sleep 1
    killall kded4
    killall knotify4
} &
