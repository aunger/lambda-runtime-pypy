#!/bin/bash -eu

source conf.sh

MD5SUM=$(md5 -q ${PYPY_VERSION}.zip)
PYPY=${PYPY_VERSION//-*}
S3KEY="${PYPY}/${MD5SUM}.zip"

for region in "${PYPY_REGIONS[@]}"; do
  bucket_name="${bucket_base_name}-${region}"

  echo "Uploading ${PYPY_VERSION}.zip to s3://${bucket_name}/${S3KEY}"

  aws --region $region s3 cp ${PYPY_VERSION}.zip "s3://${bucket_name}/${S3KEY}"
done
