#!/bin/sh

set -x

NO_TRACE_LIBS=/opt/pypy:/usr:/var:$(python -c 'import sys ; print ":".join(sys.path)[1:]')

/opt/pypy/bin/pypy -u -v -m trace --ignore-dir=$NO_TRACE_LIBS --trace /opt/bootstrap.py
echo "Exit code $?"
