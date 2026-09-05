#!/usr/bin/env bash

BUILD=${BUILD:?Set BUILD to the configured GNU M4 build directory}
SRC=${SRC:?Set SRC to the GNU M4 1.4.21 source directory}
CXX=${CXX:-clang++}

cat > /tmp/gnulib-openat-namespace.cc <<'CPP'
#define GNULIB_NAMESPACE gnulib
#include "config.h"
#include <fcntl.h>

int main()
{
  return 0;
}
CPP

"$CXX" \
  -std=gnu++23 \
  -O2 \
  -I"$BUILD/lib" \
  -I"$SRC/lib" \
  /tmp/gnulib-openat-namespace.cc \
  -c \
  -o /tmp/gnulib-openat-namespace.o
