# Marek Sapota’s dotfiles

These are configuration files for many programs that I use.  As a whole they are
probably only useful to me but since all these files are in the public domain
feel free to salvage whatever you want.

## Installation

    git clone git://github.com/maarons/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./build.py
    git submodule init
    git submodule update

The build script will not remove any configuration files you already have (but
it will remove symlinks).  Upon successful execution it will not generate any
output.

## Removal

    cd ~/.dotfiles
    ./build.py --clean

The build script will remove symlinks and any directories that were created
using the installation step.
