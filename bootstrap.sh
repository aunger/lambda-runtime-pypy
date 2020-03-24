#!/bin/sh

set -x

/opt/pypy/bin/pypy -u /opt/bootstrap.py
echo "Exit code $?"
