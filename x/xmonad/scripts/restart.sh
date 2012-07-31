#!/bin/bash

~/.xmonad/scripts/on_restart.sh before
xmonad --recompile && xmonad --restart
