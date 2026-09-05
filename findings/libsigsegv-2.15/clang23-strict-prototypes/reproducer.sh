#!/usr/bin/env bash
set -o pipefail

SRC=${SRC:?Set SRC to libsigsegv 2.15 source}
CC=${CC:?Set CC to Clang}

BUILD=${BUILD:-/tmp/libsigsegv-strict-prototypes-reproducer}

rm -rf "$BUILD"
mkdir -p "$BUILD"
cd "$BUILD" || exit 2

BASE="-O2 -Wall -Wextra -Wpedantic"

CC="$CC" \
CFLAGS="$BASE" \
"$SRC/configure" \
  --enable-shared \
  --enable-static

CONFIG_RC=$?

if [ "$CONFIG_RC" -ne 0 ]; then
    echo "CONFIGURE_RC=$CONFIG_RC"
    exit "$CONFIG_RC"
fi

make -k -j1 \
  CC="$CC" \
  CFLAGS="$BASE -Werror=strict-prototypes" \
  2>&1 | tee build.log

BUILD_RC=${PIPESTATUS[0]}

echo "BUILD_RC=$BUILD_RC"

if [ "$BUILD_RC" -ne 0 ] && \
   grep -Eiq \
     'strict-prototypes|function declaration without a prototype' \
     build.log
then
    echo 'REPRODUCER=PASS'
    exit 0
fi

echo 'REPRODUCER=FAIL'
exit 1
