#!/bin/bash -eu

source conf.sh

MD5SUM=$(md5 -q ${PYPY_VERSION}.zip)
PYPY=${PYPY_VERSION//-*}
S3KEY="${PYPY}/${MD5SUM}.zip"

for region in "${PYPY_REGIONS[@]}"; do
  bucket_name="${bucket_base_name}-${region}"

  echo "Publishing Lambda Layer ${PYPY} in region ${region}..."
  version=$(aws lambda publish-layer-version \
      --layer-name ${PYPY//.} \
      --description "${PYPY} Lambda Runtime" \
      --content "S3Bucket=${bucket_name},S3Key=${S3KEY}" \
      --compatible-runtimes provided \
      --license-info "MIT" \
      --output text \
      --query Version \
      --region $region)
  echo "Published Lambda Layer ${PYPY} in region ${region} version ${version}"

  echo "Setting public permissions on Lambda Layer ${PYPY} version ${version} in region ${region}..."
  aws lambda add-layer-version-permission \
      --layer-name ${PYPY//.} \
      --version-number $version \
      --statement-id public \
      --action lambda:GetLayerVersion \
      --principal "*" \
      --region $region \
      > /dev/null
  echo "Public permissions set on Lambda Layer ${PYPY} version ${version} in region ${region}"

done
