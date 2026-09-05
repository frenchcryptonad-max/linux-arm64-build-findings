#!/usr/bin/env bash

set +e
set +u
set -o pipefail

SRC="${SRC:?Set SRC to an unpacked libsigsegv 2.15 source tree}"
CC="${CC:-cc}"

BUILD="${BUILD:-/tmp/libsigsegv-unused-sig-reproducer}"

rm -rf "$BUILD"
mkdir -p "$BUILD"

cd "$BUILD" || exit 97

env \
  CC="$CC" \
  CFLAGS="-O2 -g" \
  "$SRC/configure" \
    --enable-static \
    --enable-shared

CONFIG_RC=$?

if [ "$CONFIG_RC" -eq 0 ]; then
    make clean >/dev/null 2>&1 || true

    make -j1 V=1 \
      CFLAGS="-O2 -g -Wall -Wextra -Wpedantic -Werror" \
      -C src handler.lo

    BUILD_RC=$?
else
    BUILD_RC=99
fi

echo "CONFIG_RC=$CONFIG_RC"
echo "STRICT_HANDLER_BUILD_RC=$BUILD_RC"

exit "$BUILD_RC"
