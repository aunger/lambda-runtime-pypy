#!/bin/bash -eu

rm -rf layer/${PYPY_VERSION}
mkdir -p layer/${PYPY_VERSION}
cp bootstrap.sh layer/${PYPY_VERSION}/bootstrap
if [[ ${PYPY_VERSION} == pypy3\.* ]]; then
    cp bootstrap.py3 layer/${PYPY_VERSION}/bootstrap.py
else
    cp bootstrap.py2 layer/${PYPY_VERSION}/bootstrap.py
fi
chmod +x layer/${PYPY_VERSION}/bootstrap
chmod +x layer/${PYPY_VERSION}/bootstrap.py
cd layer
PKG_NAME=${PYPY_VERSION}-linux_x86_64-portable
BZIP_FILE=${PKG_NAME}.tar.bz2
if [ ! -f "$BZIP_FILE" ]; then
    curl -OL https://bitbucket.org/squeaky/portable-pypy/downloads/${BZIP_FILE}
fi
cd ${PYPY_VERSION}
tar -xvjf ../${BZIP_FILE}
mv ${PKG_NAME} pypy
zip -r ../../${PYPY_VERSION}.zip .
