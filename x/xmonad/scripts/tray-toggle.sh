#!/bin/bash

pfile=/tmp/${USER}_trayer.pid

if [[ -f "$pfile" ]]; then
    pid=`cat "$pfile"`
    kill $pid
    rm "$pfile"
else
    trayer --edge top --align right --heighttype pixel --height 20 --widthtype request --monitor primary &> /dev/null &
    pid=$!
    echo $pid > "$pfile"
fi
