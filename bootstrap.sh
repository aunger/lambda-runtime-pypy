#!/bin/sh

set -x

NO_TRACE_LIBS=/opt/pypy:/usr:/var:$(python -c 'import sys ; print ":".join(sys.path)[1:]')

/opt/pypy/bin/pypy -u -v -m trace --ignore-dir=$NO_TRACE_LIBS --trace /opt/bootstrap.py

EXIT_CODE=$?
echo "Exit code $EXIT_CODE"
exit $EXIT_CODE
