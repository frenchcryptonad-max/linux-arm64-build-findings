#!/usr/bin/env bash
set +e
SRC="${1:-}"
if [ -z "$SRC" ] || [ ! -f "$SRC" ]; then
  echo 'usage: reproducer.sh /path/to/pcre2-sys-0.2.10/upstream/deps/sljit/sljit_src/sljitNativeARM_64.c'
  echo 'REPRODUCTION=NOT_RUN'
  exit 0
fi
grep -n 'sljit_s32 temp_reg)' "$SRC"
grep -n 'SLJIT_UNUSED_ARG(temp_reg)' "$SRC"
HIT=$?
echo '=== FINAL SUMMARY ==='
if [ "$HIT" -ne 0 ]; then echo 'VENDORED_UNUSED_MARKER=ABSENT'; echo 'REPRODUCTION=PASS'; else echo 'VENDORED_UNUSED_MARKER=PRESENT'; echo 'REPRODUCTION=NOT_APPLICABLE'; fi
