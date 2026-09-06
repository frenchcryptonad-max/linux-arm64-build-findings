# OsARM language repository catalog

| Language / technology | Active repository | Principal migrated records |
|---|---|---|
| C | [osarm-c-findings](https://github.com/frenchcryptonad-max/osarm-c-findings) | GMP, Mini-GMP, libsigsegv, SLJIT C findings and fixes |
| C++ | [osarm-cpp-findings](https://github.com/frenchcryptonad-max/osarm-cpp-findings) | GNU M4 / Gnulib / Clang C++ openat finding and fix record |
| Rust | [osarm-rust-findings](https://github.com/frenchcryptonad-max/osarm-rust-findings) | pcre2-sys AArch64 musl JIT finding/fix and ripgrep runtime audit |
| JavaScript / Node.js | [osarm-nodejs-findings](https://github.com/frenchcryptonad-max/osarm-nodejs-findings) | npm runtime dependency advisory and remediation investigation |

## Repository policy

The language repository is chosen by the implementation technology under investigation, not by the shell language of the reproduction harness.

`findings/` proves reproducible problems. `fixes/` contains patch candidates or validated fixes. `audits/` preserves verified NO_FINDING results or investigations that do not justify a fix.

The original combined repository remains as an index and immutable historical source through its existing Git history.
