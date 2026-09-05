# Desktop Commander 0.2.48 security remediation investigation

Status: INVESTIGATION / NO VALIDATED FIX

Finding: `findings/desktop-commander-0.2.48/npm-runtime-dependency-advisories/`

## What was tested

- update `sharp` from the 0.34.x line to 0.35.4;
- force `uuid` 11.1.1 while retaining ExcelJS 4.4.0;
- run focused Sharp, PDF-image, ExcelJS and UUID compatibility checks;
- build Desktop Commander source;
- compare source test failures against unmodified v0.2.48;
- pack the package and install it as a downstream consumer to test whether dependency-internal npm `overrides` survive publication.

## Established results

- an isolated root-level override workspace resolved sharp 0.35.4 and uuid 11.1.1 with npm audit reporting zero runtime advisories;
- Sharp ARM64 image operations PASS;
- Desktop Commander PDF image extraction with Sharp 0.35.4 PASS;
- ExcelJS write/read round-trip with UUID 11.1.1 PASS;
- Desktop Commander build PASS with no build warnings/errors observed;
- full source test suite: 45/49 PASS; the same four tests fail on the unmodified v0.2.48 control, so these failures are not attributed to the dependency candidate;
- a published dependency package cannot enforce its own `overrides` on the consuming root; downstream installation resolved uuid 8.3.2 again.

## Decision

The root-level override experiment is not a valid upstream fix. No files in the active Desktop Commander installation were modified. A general remediation requires an upstream dependency change that remains effective for consumers (for example an ExcelJS/uuid dependency update or another supported dependency strategy).

## Source-suite control

The candidate and unmodified v0.2.48 control both failed the same four source tests: `test-literal-search.js`, `test-pdf-creation.js`, `test-search-code-edge-cases.js`, and `test-search-code.js`. The three search-related failures report inability to extract a streaming search session identifier. The PDF-creation control fails while launching the cached Chromium/Puppeteer executable on the reproduced ARM64 environment. These failures are recorded as pre-existing test/environment failures and are not attributed to the dependency experiment.
