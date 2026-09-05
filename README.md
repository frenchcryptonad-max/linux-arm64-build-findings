# linux-arm64-build-findings

Reproducible Linux ARM64 build, toolchain, runtime and dependency compatibility findings maintained for the OsARM bottom-up validation process.

## Repository model

The repository is organized by lifecycle, not by programming language:

- `audits/<component-version>/<audit-id>/` preserves validated NO_FINDING results, corrected diagnostics, and investigations that do not justify a finding or fix.
- `findings/<component-version>/<finding-id>/` proves a reproducible problem or compatibility limitation.
- `fixes/<component-version>/<finding-id>/` contains a separate patch candidate or validated fix with before/after evidence.
- AUDIT, FINDING and FIX records are published with separate traceable scopes; FINDING and FIX remain separate commits.
- `SHA256SUMS` files protect the published evidence sets.

A finding may span several technologies. Current evidence includes C, C++, Rust, GNU Autoconf/M4, Gnulib, SLJIT, JavaScript/TypeScript, Node.js/npm and shell test harnesses.

Shell files in this repository are primarily reproducibility harnesses. They do not imply that the underlying component or correction is written in Shell. For example, GMP and SLJIT findings concern C source, while the pcre2-sys JIT correction changes Rust build logic and exercises C/SLJIT code.

See [CATALOG.md](CATALOG.md) for the component/status/technology index.
