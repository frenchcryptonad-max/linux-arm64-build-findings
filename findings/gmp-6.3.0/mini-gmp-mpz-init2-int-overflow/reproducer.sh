#!/usr/bin/env bash
SRC="${GMP_SRC:-/osarm-build/sources/gmp/gmp-6.3.0}"
CC="${CC:-cc}"
HERE="$(cd "$(dirname "$0")" && pwd)"
BIN="${TMPDIR:-/tmp}/mini-gmp-mpz-init2-int-overflow.$$"
"$CC" -std=gnu17 -O2 -I"$SRC/mini-gmp" "$HERE/reproducer.c" "$SRC/mini-gmp/mini-gmp.c" -o "$BIN"
BUILD_RC=$?
if [ "$BUILD_RC" -eq 0 ]; then "$BIN"; RUN_RC=$?; else RUN_RC=99; fi
rm -f "$BIN"
echo "BUILD_RC=$BUILD_RC"
echo "RUN_RC=$RUN_RC"
exit "$RUN_RC"
