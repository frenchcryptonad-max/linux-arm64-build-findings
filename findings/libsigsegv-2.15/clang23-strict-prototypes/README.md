# libsigsegv 2.15 triggers Clang 23 strict-prototypes diagnostic

## Summary

The tested libsigsegv 2.15 Linux AArch64 build contains a C declaration
that Clang 23 diagnoses under `-Wstrict-prototypes`.

Promoting this diagnostic to an error prevents a strict Clang build.

The equivalent GCC 15 targeted build completed successfully in the
tested matrix.

## Tested environment

- libsigsegv: 2.15
- Architecture: AArch64
- Linux / glibc
- Clang/Clang++: 23.1.0
- GCC/G++: 15.x
- targeted diagnostic:
  `-Werror=strict-prototypes`

## Expected result

The relevant C declarations compile without strict-prototypes
diagnostics under the tested strict Clang policy.

## Observed result

Clang 23:

- configure: PASS
- strict-prototypes build: FAIL

GCC 15:

- configure: PASS
- strict-prototypes build: PASS

## Current scope

The demonstrated scope is compiler-dependent in the tested matrix.

This finding does not establish that:

- GCC is affected;
- every Clang version is affected;
- the issue is specific to AArch64;
- there is a runtime bug;
- there is a security vulnerability.

Additional compiler/platform testing would be required before broadening
the conclusion.
