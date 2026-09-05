# pcre2-sys 0.2.10 vendored SLJIT ARM64 unused temp_reg warning

Status: FINDING
Upstream SLJIT status: ACCEPTED / FIXED UPSTREAM

Component: pcre2-sys 0.2.10 vendored SLJIT
File: deps/sljit/sljit_src/sljitNativeARM_64.c
Architecture: AArch64 without `__ARM_FEATURE_ATOMICS`

## Summary

When the vendored PCRE2 JIT path is compiled on the reproduced AArch64 target,
GCC reports `temp_reg` as unused in `sljit_emit_atomic_store` when ARM LSE
atomics are not enabled.

Current SLJIT upstream already fixes this condition in commit
`1fade852b2218924d1e2ceb7bea87350441eedbb` (`aarch64: avoid
-Wunused_parameter in older CPUs (#324)`, 2025-08-11) by marking `temp_reg`
unused for the non-LSE configuration.

## Observed

`sljitNativeARM_64.c:3377:19: warning: unused parameter 'temp_reg' [-Wunused-parameter]`

## Scope

The warning is in the SLJIT source vendored by pcre2-sys 0.2.10. It is not a
new SLJIT upstream defect; upstream SLJIT has already accepted a correction.

## Fix

No fix is included here. The separate fix directory contains the minimal
backport used for validation.
