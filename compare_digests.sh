#!/bin/bash
# 2020-12-21: DOCKER_CLI_EXPERIMENTAL=enabled must be set in order for this to work
# Returns 0 when there are no changes and 1 when there are changes
SOURCE_IMAGE="$1"
TARGET_IMAGE="$2"

if docker manifest inspect "$SOURCE_IMAGE" > sourcemanifest.json; then
  SOURCE_IMAGE_DIGEST=$(jq --raw-output '.config.digest' < ./sourcemanifest.json)
  if docker manifest inspect "$TARGET_IMAGE" > targetmanifest.json; then
    TARGET_IMAGE_DIGEST=$(jq --raw-output '.config.digest' < ./targetmanifest.json)
    if [ "$SOURCE_IMAGE_DIGEST" = "$TARGET_IMAGE_DIGEST" ]; then
      echo "false"
      exit 0
    fi
  fi
  echo "true"
else
  exit 1
fi

