#!/bin/sh

./build.py --clean
git pull
git submodule init
git submodule update
./build.py
