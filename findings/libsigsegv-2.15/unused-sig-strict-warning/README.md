# libsigsegv 2.15 fails strict warning builds on an unused signal parameter

## Summary

libsigsegv 2.15 builds successfully with both Clang and GCC when standard
warnings are enabled, but the `handler.lo` target fails when the same warnings
are promoted to errors with `-Werror`.

The reproducible diagnostic is an unused `sig` parameter originating from the
fault-handler argument macro used by `handler-unix.c`.

## Scope

Validated on:

- Linux AArch64
- libsigsegv 2.15
- Clang 23.1.0
- GCC 15.x
- glibc 2.43

Both tested compilers reproduce the warning.

This finding demonstrates warning-hygiene incompatibility with strict
`-Wunused-parameter -Werror` builds.

It does not establish a functional defect in SIGSEGV handling, stack-overflow
handling, AArch64 support, or relocatable installation.

## Expected result

The selected source target compiles cleanly under:

`-Wall -Wextra -Wpedantic -Werror`

## Observed result

Without `-Werror`, compilation succeeds with an unused-parameter warning.

With `-Werror`, compilation fails because the warning is promoted to an error.

## Reproducer

Run `reproducer.sh` from an unpacked libsigsegv 2.15 source tree.

## Status

FINDING

No fix is included in this directory.

Any validated correction will be published separately under `fixes/`.
