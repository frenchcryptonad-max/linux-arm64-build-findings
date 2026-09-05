# Desktop Commander 0.2.48 runtime and bundled ripgrep ARM64 validation

Status: AUDIT / NO FINDING

Component: @wonderwhy-er/desktop-commander 0.2.48
Architecture: AArch64 Linux

## Scope

This audit records the post-install runtime/service health check and the corrected diagnosis of Desktop Commander bundled ripgrep resolution on ARM64.

## Result

- persistent user service active and enabled after reboot;
- no runtime crash/OOM/coredump condition established during the check;
- bundled ripgrep is resolved through `@vscode/ripgrep-linux-arm64/bin/rg`;
- bundled ripgrep version observed: 15.0.0;
- executable mode and search execution: PASS;
- NEON compile/runtime support: active;
- PCRE2 available; the bundled binary reported JIT unavailable, which was investigated separately under the pcre2-sys finding/fix records;
- no ripgrep ARM64 defect was established, so no finding/fix is claimed here.

## Correction of earlier diagnostic

An earlier probe looked only under `@vscode/ripgrep` and incorrectly inferred that the binary was absent. The package uses the architecture-specific `@vscode/ripgrep-linux-arm64` package. This audit supersedes that probe result.

## Runtime log counting note

An initial keyword counter incorrectly counted occurrences of words such as `error` and `warning` that appeared inside Desktop Commander tool-call arguments logged by the service itself. A second pass restricted the review to actual runtime messages; no genuine runtime warning, error, authentication failure, crash, OOM, or coredump was established in the reviewed boot/service window.
