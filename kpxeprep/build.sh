#!/usr/bin/env bash
# Stop on first error
set -e

IMAGENAME="kpxebuilder"
TAG="latest"
MOUNTS="-v $(pwd)/../docker/files:/tmp/files:z -v $(pwd):/tmp/build:z -w /tmp/build"

image=$(docker images --format "{{.Repository}}\t{{.Tag}}\t{{.CreatedAt}}" "${IMAGENAME}:${TAG}")
time=$(echo "${image}" | cut -f 3)
if [ -n "${image}" ]; then
    echo "${IMAGENAME} found, not rebuilding."
    echo "Remove the existing image if you want to force a rebuild."
else
    echo "${IMAGENAME} not found, building..."
    docker build . -t "${IMAGENAME}"
fi
docker run --rm -it ${MOUNTS} -u $(id -u) "${IMAGENAME}" ${@}
