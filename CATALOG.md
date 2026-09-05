# OsARM findings and fixes catalog

| Component | Record | Status | Primary technologies |
|---|---|---|---|
| GNU M4 1.4.21 / Gnulib | `findings/gnu-m4-1.4.21/clang23-aarch64-openat-namespace` | FINDING | C, C++, Gnulib, Clang |
| GNU M4 1.4.21 / Gnulib | `fixes/gnu-m4-1.4.21/clang23-aarch64-openat-namespace` | FIX record | C, Gnulib |
| libsigsegv 2.15 | `findings/libsigsegv-2.15/*` | FINDINGS | C, Clang/GCC |
| GMP 6.3.0 | `findings/gmp-6.3.0/c23-empty-parameter-configure-probe` | FINDING | C23, Autoconf, shell probe |
| GMP 6.3.0 Mini-GMP | `findings/gmp-6.3.0/mini-gmp-mpz-init2-int-overflow` | FINDING | C, integer metadata, allocator callbacks |
| GMP tip ab4a7408e2ce | `findings/gmp-tip-ab4a7408e2ce/c23-knr-lshift-com-probes` | FINDING | C23, Autoconf |
| GMP tip ab4a7408e2ce | `fixes/gmp-tip-ab4a7408e2ce/c23-knr-lshift-com-probes` | VALIDATED FIX | C, Autoconf |
| pcre2-sys 0.2.10 | `findings/pcre2-sys-0.2.10/aarch64-musl-jit-disabled-clear-cache-link` | FINDING / NO_ACTIVATABLE | Rust build.rs, PCRE2 C, SLJIT, musl, AArch64 |
| pcre2-sys 0.2.10 | `fixes/pcre2-sys-0.2.10/aarch64-musl-jit-disabled-clear-cache-link` | PATCH CANDIDATE | Rust build.rs, libgcc, PCRE2 JIT |
| pcre2-sys 0.2.10 vendored SLJIT | `findings/pcre2-sys-0.2.10/vendored-sljit-arm64-unused-temp-reg` | FINDING / FIXED UPSTREAM | C, SLJIT, AArch64 |
| pcre2-sys 0.2.10 vendored SLJIT | `fixes/pcre2-sys-0.2.10/vendored-sljit-arm64-unused-temp-reg` | VALIDATED FIX / backport | C, SLJIT |
| Desktop Commander 0.2.48 | `findings/desktop-commander-0.2.48/npm-runtime-dependency-advisories` | FINDING | Node.js, npm, JavaScript/TypeScript dependencies |

## Recent traceability

- `e083bbb0ee96b0edd59df4b66402198166183233` — pcre2-sys AArch64 musl JIT linkage finding.
- `de45b441e5d21de79ff9ce9eb7dad028778f9c61` — pcre2-sys AArch64 musl JIT patch candidate.
- `4263a0a1f49d7d446d7dc151bc3d5db9aba3c105` — vendored SLJIT ARM64 unused-parameter finding.
- `05e305ad39d44ab6b150864f7b8072bb415ca590` — validated SLJIT ARM64 backport.
- `e109fdb60dfc545f31a4d89795f1a22f3970fbb9` — Desktop Commander 0.2.48 runtime dependency advisory finding.

## Status vocabulary

`FINDING` proves a problem. `PATCH CANDIDATE` is not yet a validated general fix. `VALIDATED FIX` has passed the applicable targeted, full and non-regression validation. Upstream state is recorded independently when known.
