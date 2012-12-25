#!/bin/sh

./build.py --clean
git pull
git submodule init
git submodule update
cd vim/bundle/command-t/ruby/command-t
git clean -dfx
ruby extconf.rb
make
cd -
./build.py
