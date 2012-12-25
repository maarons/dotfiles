#!/usr/bin/env python
#
# build.py
# The author disclaims copyright to this source code. It is placed in
# the public domain. In case this is not legally possible I grant anyone
# the right to use it for any purpose, without any conditions, unless
# such conditions are required by law.

from __future__ import print_function
import argparse
import json
import os
import sys
from os.path import (
    abspath,
    expanduser,
    islink,
    exists,
    lexists,
    realpath,
    dirname
)

parser = argparse.ArgumentParser()
parser.add_argument(
    '--clean',
    '-c',
    action = 'store_true',
    help = 'clean instead of building'
)
args = parser.parse_args()

skipped = []

def sym_link(target, source):
    if args.clean:
        if not lexists(target):
            # Already clean.
            return
        if islink(target) and realpath(target) == realpath(source):
            os.remove(target)
        else:
            skipped.append(target)
    else:
        if islink(target):
            os.remove(target)
        if exists(target):
            skipped.append(target)
        else:
            os.symlink(source, target)

def mkdir(target):
    if args.clean:
        empty = True
        while empty:
            try:
                os.rmdir(target)
                # Go one dir up and clean again.
                target = dirname(target)
            except:
                empty = False
    else:
        if not exists(target):
            os.makedirs(target)

try:
    with open('config.json') as c:
        conf = json.load(c)
except:
    print(
        'Something is wrong with the config file, is it proper JSON?',
        file = sys.stderr
    )
    sys.exit(1)

def do_mkdir():
    if 'mkdir' in conf:
        for path in conf['mkdir']:
            path = abspath(expanduser(path))
            mkdir(path)

def do_chmod():
    if 'chmod' in conf:
        for path in conf['chmod']:
            mod = int(conf['chmod'][path], 8)
            path = abspath(expanduser(path))
            os.chmod(path, mod)

def do_symlink():
    if 'symlink' in conf:
        for source in conf['symlink']:
            source_path = abspath(expanduser(source))
            targets = conf['symlink'][source]
            if not isinstance(targets, list):
                targets = [targets]
            for target in targets:
                target_path = abspath(expanduser(target))
                sym_link(target_path, source_path)

if args.clean:
    do_symlink()
    do_mkdir()
else:
    do_mkdir()
    do_chmod()
    do_symlink()

if skipped:
    if args.clean:
        print(
            'Seems like these files were not installed by this script,\n'
            'so they were not removed:',
            file = sys.stderr
        )
    else:
        print(
            'These files were already present, and they were left alone:',
            file = sys.stderr
        )
    for f in skipped:
        print(f, file = sys.stderr)
