#!/usr/bin/env sh

docker build . -t pxebuilder

if [ -z "$@" ]; then
  ARGS="all pxeoverlay"
else
  ARGS="$@"
fi

docker run --rm -it -v $(pwd):/tmp/build -w /tmp/build -u $(id -u) pxebuilder ${ARGS}
