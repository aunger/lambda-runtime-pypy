#!/bin/bash -eu

publicize=0
while getopts "p" opt
do
    case $opt in
    (p) publicize=1 ;;
    (*) exit 1 ;;
    esac
done

source conf.sh

RUNTIME_ZIP="${PYPY_VERSION}.zip"
MD5SUM=$(type -P md5 && md5 -q $RUNTIME_ZIP || md5sum $RUNTIME_ZIP | awk '{ print $1 }')
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

  if (( publicize )); then
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
  fi

done
