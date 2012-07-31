#!/bin/bash

path=""

if [[ -n "$1" ]]; then
    path="$1"
    echo "$path" > ~/.wallpaper
else
    path=`cat ~/.wallpaper`
    if [[ "$?" -ne 0 ]]; then
        path=""
    fi
fi

if [[ -n "$path" ]]; then
    feh -zr --bg-max "$path"
fi
