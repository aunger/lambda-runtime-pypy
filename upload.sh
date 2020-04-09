#!/bin/bash -eu

source conf.sh

RUNTIME_ZIP="${PYPY_VERSION}.zip"
MD5SUM=$(type -P md5 && md5 -q $RUNTIME_ZIP || md5sum $RUNTIME_ZIP | awk '{ print $1 }')
PYPY=${PYPY_VERSION//-*}
S3KEY="${PYPY}/${MD5SUM}.zip"

for region in "${PYPY_REGIONS[@]}"; do
  bucket_name="${bucket_base_name}-${region}"

  echo "Uploading $RUNTIME_ZIP to s3://${bucket_name}/${S3KEY}"

  aws --region $region s3 cp $RUNTIME_ZIP "s3://${bucket_name}/${S3KEY}"
done
