# pcre2-sys 0.2.10 AArch64 musl JIT fix candidate

Status: PATCH CANDIDATE

Finding: `findings/pcre2-sys-0.2.10/aarch64-musl-jit-disabled-clear-cache-link/`

## Candidate

For `aarch64-unknown-linux-musl`:

1. stop suppressing `SUPPORT_JIT`;
2. after building the bundled static PCRE2 library, request linkage of the
   GCC runtime so SLJIT's `__clear_cache` reference is resolved.

## Validation completed

- native AArch64 musl pcre2 0.2.11: 24 unit + 7 doctests PASS;
- explicit `PCRE2_CONFIG_JIT=1` PASS;
- JIT-required lookbehind/backreference/multiline/caseless cases PASS;
- 100,000 JIT match stress iterations PASS;
- AArch64 GNU pcre2 0.2.11: 24 unit + 7 doctests PASS;
- ripgrep 15.2.0 AArch64 musl integration harness: JIT available and
  lookaround/backreference/multiline/100,000-line search PASS.

The warning-clean runs also apply the separate vendored-SLJIT warning backport
tracked under `vendored-sljit-arm64-unused-temp-reg`.

## Limits

This is not yet a general upstream validated fix. `cargo:rustc-link-lib=gcc`
is proven in the reproduced GCC/musl environment but has not yet been tested
against clang-only or other AArch64 musl linker/runtime configurations.
The stock ripgrep musl build is additionally blocked on this VM by a separate
tikv-jemalloc build failure; the ripgrep JIT integration test therefore used
a test-harness-only allocator bypass and does not claim a jemalloc fix.
