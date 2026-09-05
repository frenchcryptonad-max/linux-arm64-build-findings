# Validated fix: Gnulib openat C++ namespace warning with Clang 23

## Status

VALIDATED FIX

Related finding:

- clang23-aarch64-openat-namespace
- finding commit: 3188465

## Problem

GNU M4 1.4.21's bundled Gnulib used:

    _GL_CXXALIASWARN (openat);

Gnulib documents that macro for functions without overloaded variants.

In the tested glibc/Clang environment, openat is visible as an
overloaded function set and Clang reports:

    reference to overloaded function could not be resolved

## Fix

Replace the generic warning alias with Gnulib's overload-aware form:

    _GL_CXXALIASWARN1 (openat, int,
                        (int fd, char const *file, int flags,
                         /* mode_t mode */ ...));

No C++ support, namespace support, Fortify support, fallback behavior
or compiler diagnostic is disabled.

## Compiler validation

After the fix:

- Clang 23 C++17 namespace: PASS
- Clang 23 C++20 namespace: PASS
- Clang 23 C++23 namespace: PASS
- Clang 23 C++23 namespace without Fortify: PASS
- Clang 23 C++23 without namespace: PASS
- G++ 15 C++23 namespace: PASS

## Fresh-build causal matrix

    ORIGINAL CONFIG=0 BUILD=0 FCNTL=2 FLOAT=0 CHECK=2
    FLOAT_ONLY CONFIG=0 BUILD=0 FCNTL=2 FLOAT=0 CHECK=2
    OPENAT_ONLY CONFIG=0 BUILD=0 FCNTL=0 FLOAT=0 CHECK=0
    BOTH CONFIG=0 BUILD=0 FCNTL=0 FLOAT=0 CHECK=0

The openat patch is therefore necessary and sufficient for the
observed failure in this environment.

The temporary float_h investigation was not required in fresh builds
and is not part of this fix.

## Evidence integrity

source-evidence-SHA256SUMS.txt contains hashes of the original local
validation artifacts before publication processing.

Public copies only have local paths anonymized and trailing whitespace
normalized.

SHA256SUMS contains hashes of the final files published in this
directory.

## Validation scope

Validated with:

- GNU M4 1.4.21
- bundled Gnulib
- Linux AArch64
- glibc 2.43
- Clang/Clang++ 23.1.0
- G++ 15.2.0
- C++ support enabled

This does not claim universal applicability to every Gnulib revision,
libc, compiler, architecture or operating system.
