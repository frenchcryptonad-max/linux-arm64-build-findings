# OsARM build findings — repository index

This repository is the historical index for the OsARM reproducible ARM64 build, toolchain, runtime and dependency findings project.

Active records are now separated by implementation language so that findings, fixes and source evidence are published in the repository matching the technology being investigated.

## Active language repositories

- **C** — [osarm-c-findings](https://github.com/frenchcryptonad-max/osarm-c-findings)
- **C++** — [osarm-cpp-findings](https://github.com/frenchcryptonad-max/osarm-cpp-findings)
- **Rust** — [osarm-rust-findings](https://github.com/frenchcryptonad-max/osarm-rust-findings)
- **JavaScript / Node.js** — [osarm-nodejs-findings](https://github.com/frenchcryptonad-max/osarm-nodejs-findings)

Each active repository keeps the OsARM lifecycle separation between `findings/`, `fixes/` and `audits/` where applicable. Reproducer shell scripts remain support harnesses only; they are not the implementation language of the underlying finding or correction.

The pre-split records remain permanently available in this repository's Git history. Public history has not been rewritten or discarded.

See [CATALOG.md](CATALOG.md) for the routing table.
