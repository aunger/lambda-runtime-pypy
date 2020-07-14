#!/bin/bash -eu

rm -rf layer/${PYPY_VERSION}
mkdir -p layer/${PYPY_VERSION}
if [[ ${PYPY_VERSION} == pypy3\.* ]]; then
    cp bootstrap.py3 layer/${PYPY_VERSION}/bootstrap
else
    cp bootstrap.py2 layer/${PYPY_VERSION}/bootstrap
fi
chmod +x layer/${PYPY_VERSION}/bootstrap
cd layer
PKG_NAME=${PYPY_VERSION}-linux64
BZIP_FILE=${PKG_NAME}.tar.bz2
if [ ! -f "$BZIP_FILE" ]; then
    curl -OL https://bitbucket.org/pypy/pypy/downloads/${BZIP_FILE}
fi
cd ${PYPY_VERSION}
echo Extracting files from pypy download. Be patient.
tar -xjf ../${BZIP_FILE}
mv ${PKG_NAME} pypy
echo Compressing Lambda layer files. Be patient.
zip -r -q ../../${PYPY_VERSION}.zip .
