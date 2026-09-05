# libsigsegv 2.15 additional unused parameters prevent strict warning-clean builds

## Summary

libsigsegv 2.15 contains several additional unused function parameters
that are diagnosed by both Clang 23 and GCC 15 when compiling the tested
Linux AArch64 configuration with warning diagnostics enabled.

Promoting `-Wunused-parameter` to an error causes the build to fail.

This finding deliberately excludes the parameter `sig`, which is already
tracked separately by:

`findings/libsigsegv-2.15/unused-sig-strict-warning`

## Parameters reproduced

The following additional parameters were observed with both tested
compilers:

- `address`
- `arg1`
- `arg2`
- `arg3`
- `scp`
- `serious`

## Tested environment

- libsigsegv: 2.15
- Architecture: AArch64
- Linux / glibc
- Clang/Clang++: 23.1.0
- GCC/G++: 15.x
- strict diagnostic:
  `-Werror=unused-parameter`

## Expected result

The relevant libsigsegv sources compile without unused-parameter
diagnostics when strict warning hygiene is requested.

## Observed result

Both Clang and GCC diagnose the additional parameters listed above.

When `-Wunused-parameter` is promoted to an error, the build returns a
non-zero status.

## Scope

This establishes warning-hygiene failures in the tested compiler and
platform matrix.

It does not establish:

- a runtime functional bug;
- memory corruption;
- a security vulnerability;
- an AArch64-specific defect;
- identical behavior on every compiler or operating system.

## Relationship to existing finding

The previously published `sig` finding remains separate and unchanged.

This report covers only the additional unused parameters discovered after
continuing the strict full-build analysis.
