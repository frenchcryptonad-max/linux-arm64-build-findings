#!/usr/bin/env bash

SRC="${SRC:?SRC required}"
GCC="${GCC:-gcc}"
GXX="${GXX:-g++}"
CLANG="${CLANG:-clang}"
CLANGXX="${CLANGXX:-clang++}"
LOGDIR="${LOGDIR:?LOGDIR required}"

WORK="${TMPDIR:-/tmp}/gmp-c23-reproducer-$$"
rm -rf "$WORK"
mkdir -p "$WORK" "$LOGDIR"

run_cfg() {
  local name="$1"
  local cc="$2"
  local cxx="$3"
  local flags="$4"
  local build="$WORK/$name"

  mkdir -p "$build"

  (
    cd "$build" || exit 99
    ABI=64 \
    CC="$cc" \
    CXX="$cxx" \
    CFLAGS="$flags" \
    "$SRC/configure" \
      --enable-cxx \
      --disable-static \
      --enable-shared
  ) >"$LOGDIR/$name.log" 2>&1

  return $?
}

run_cfg gcc-default "$GCC" "$GXX" '-O2'
gcc_default=$?

run_cfg gcc-gnu17 "$GCC" "$GXX" '-O2 -std=gnu17'
gcc_17=$?

run_cfg gcc-gnu23 "$GCC" "$GXX" '-O2 -std=gnu23'
gcc_23=$?

run_cfg clang-gnu17 "$CLANG" "$CLANGXX" '-O2 -std=gnu17'
clang_17=$?

run_cfg clang-gnu23 "$CLANG" "$CLANGXX" '-O2 -std=gnu23'
clang_23=$?

echo "GCC_DEFAULT=$([ "$gcc_default" -eq 0 ] && echo PASS || echo FAIL)"
echo "GCC_GNU17=$([ "$gcc_17" -eq 0 ] && echo PASS || echo FAIL)"
echo "GCC_GNU23=$([ "$gcc_23" -eq 0 ] && echo PASS || echo FAIL)"
echo "CLANG_GNU17=$([ "$clang_17" -eq 0 ] && echo PASS || echo FAIL)"
echo "CLANG_GNU23=$([ "$clang_23" -eq 0 ] && echo PASS || echo FAIL)"

RESULT=0
[ "$gcc_default" -ne 0 ] || RESULT=1
[ "$gcc_17" -eq 0 ] || RESULT=1
[ "$gcc_23" -ne 0 ] || RESULT=1
[ "$clang_17" -eq 0 ] || RESULT=1
[ "$clang_23" -ne 0 ] || RESULT=1

if [ "$RESULT" -eq 0 ]; then
  echo 'REPRODUCER=PASS'
else
  echo 'REPRODUCER=FAIL'
fi

rm -rf "$WORK"
exit "$RESULT"
