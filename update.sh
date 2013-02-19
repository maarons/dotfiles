#!/bin/sh

./build.py --clean
git pull --ff-only
git submodule init
git submodule update
./build.py
