#!/usr/bin/env bash
set -o pipefail

SRC=${SRC:?Set SRC to libsigsegv 2.15 source}
CC=${CC:?Set CC to clang or gcc}

BUILD=${BUILD:-/tmp/libsigsegv-unused-parameter-reproducer}

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

if "$CC" --version 2>&1 | head -1 | grep -qi clang; then
    EXTRA="-ferror-limit=0"
else
    EXTRA="-fmax-errors=0"
fi

make -k -j1 \
  CC="$CC" \
  CFLAGS="$BASE -Werror=unused-parameter $EXTRA" \
  2>&1 | tee build.log

BUILD_RC=${PIPESTATUS[0]}

echo "BUILD_RC=$BUILD_RC"

EXPECTED="address arg1 arg2 arg3 scp serious"

MISSING=0

for p in $EXPECTED; do
    if grep -Eq \
      "unused parameter ['‘\`]$p['’\`]" \
      build.log
    then
        echo "REPRODUCED_UNUSED_PARAMETER=$p"
    else
        echo "NOT_REPRODUCED_UNUSED_PARAMETER=$p"
        MISSING=1
    fi
done

if [ "$BUILD_RC" -ne 0 ] && [ "$MISSING" -eq 0 ]; then
    echo 'REPRODUCER=PASS'
    exit 0
fi

echo 'REPRODUCER=FAIL'
exit 1
