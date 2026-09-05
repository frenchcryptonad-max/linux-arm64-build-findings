# Desktop Commander 0.2.48 npm runtime dependency advisory exposure

Status: FINDING

Component: @wonderwhy-er/desktop-commander 0.2.48
Runtime: Node.js / npm
Architecture reproduced: AArch64 Linux

## Summary

A clean dependency resolution for Desktop Commander 0.2.48 is reported by npm audit as containing runtime advisory exposure through `sharp` and `uuid` (the latter via `exceljs`).

The finding records package-manager advisory metadata and dependency resolution. It does not claim that every advisory is reachable or exploitable through every Desktop Commander code path.

## Observed

- npm audit runtime total: 4
- high: 2
- moderate: 2
- critical: 0
- resolved `sharp`: 0.34.5
- resolved `exceljs`: 4.4.0
- resolved `uuid`: 8.3.2

Relevant advisories observed in the npm audit data include `GHSA-f88m-g3jw-g9cj` for sharp/libvips inheritance and `GHSA-w5hq-g745-h8pq` for uuid.

## Scope and limits

Reproduced against the npm registry dependency graph available during the audit. Advisory state can change as registry metadata changes. No fix is included in this finding.
