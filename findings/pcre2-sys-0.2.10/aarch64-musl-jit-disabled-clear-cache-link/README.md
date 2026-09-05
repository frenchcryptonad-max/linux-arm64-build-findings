# pcre2-sys 0.2.10 AArch64 musl JIT disabled by cache-flush link gap

Status: FINDING

Component: rust-pcre2 / pcre2-sys 0.2.10
Target: aarch64-unknown-linux-musl
Classification: NO_ACTIVATABLE

## Summary

pcre2-sys 0.2.10 explicitly disables PCRE2 JIT for
aarch64-unknown-linux-musl. The current rust-pcre2 upstream branch still
contains this target-specific guard.

On the reproduced native AArch64 musl environment, removing only that guard
allows PCRE2 JIT code to compile, but a high-level JIT user fails at final
link with an undefined `__clear_cache` reference from SLJIT.

The required symbol is present in GCC libgcc on the reproduced system.
Linking the GCC runtime resolves the symbol and makes PCRE2 JIT compile and
execute successfully. This finding does not claim that the same link remedy
is portable to every AArch64 musl toolchain.

## Expected

If the toolchain provides a working instruction-cache flush implementation,
AArch64 musl should be able to use PCRE2 JIT rather than disabling it solely
by target triple.

## Observed

- stock pcre2-sys: `PCRE2_CONFIG_JIT=0`;
- guard removed, no runtime link addition: undefined reference to `__clear_cache`;
- GCC libgcc exports `__clear_cache` and `__aarch64_sync_cache_range`;
- guard removed plus GCC runtime linked: JIT compile and match succeed.

## Upstream history

The AArch64 musl guard was introduced by rust-pcre2 commit
`13971efc49531618725ee07037b4f86f6193327e` in 2023. Its commit message says
the target did not build and explicitly suggests the PCRE2 build script may
need to be fixed. Current rust-pcre2 HEAD checked during this finding still
contains the guard.

## Scope and limits

Reproduced on native AArch64 with Rust 1.98.1, GCC 15.2.0, musl 1.2.5,
pcre2-sys 0.2.10 and pcre2 0.2.11. The proposed GCC-runtime link path has not
been established as a general solution for clang-only or non-GCC musl
linkers.

## Fix

No fix is included in this finding. See the separately maintained fix
candidate under `fixes/pcre2-sys-0.2.10/aarch64-musl-jit-disabled-clear-cache-link/`.
