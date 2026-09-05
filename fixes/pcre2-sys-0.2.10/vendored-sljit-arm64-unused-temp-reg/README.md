# pcre2-sys 0.2.10 vendored SLJIT unused temp_reg validated backport

Status: VALIDATED FIX

Finding: `findings/pcre2-sys-0.2.10/vendored-sljit-arm64-unused-temp-reg/`
Upstream SLJIT fix: `1fade852b2218924d1e2ceb7bea87350441eedbb`

The backport adds the upstream `SLJIT_UNUSED_ARG(temp_reg)` marker to the
vendored ARM64 implementation. It changes no generated instruction path.

Validation with the AArch64 musl JIT path enabled:

- pcre2 0.2.11 unit tests: 24/24 PASS;
- pcre2 0.2.11 doctests: 7/7 PASS;
- strict observed build warning count: 0;
- build error count: 0;
- AArch64 GNU non-regression: 24/24 + 7/7 PASS, 0 warnings, 0 errors;
- JIT-required functional and stress tests PASS.

This fix is already represented upstream in SLJIT. The remaining integration
question is updating/backporting the vendored SLJIT copy in rust-pcre2.
