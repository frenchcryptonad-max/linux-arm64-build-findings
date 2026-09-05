#!/usr/bin/env bash
set +e
WORK="${TMPDIR:-/tmp}/osarm-pcre2-sys-aarch64-musl-jit-repro"
rm -rf "$WORK"
mkdir -p "$WORK/probe/src"
FAIL=0
for C in cargo rustc musl-gcc python3; do command -v "$C" >/dev/null 2>&1 || FAIL=1; done
rustup target list --installed 2>/dev/null | grep -qx 'aarch64-unknown-linux-musl' || FAIL=1
if [ "$FAIL" -ne 0 ]; then
  echo 'PRECHECK=FAIL'; echo 'REPRODUCTION=NOT_RUN'; exit 0
fi
cat > "$WORK/probe/Cargo.toml" <<'TOML'
[package]
name="osarm-pcre2-jit-repro"
version="0.1.0"
edition="2024"
[dependencies]
pcre2-sys="=0.2.10"
TOML
cat > "$WORK/probe/src/main.rs" <<'RS'
use std::ffi::c_void;
fn main(){
 let mut jit:u32=99;
 let rc=unsafe{pcre2_sys::pcre2_config_8(pcre2_sys::PCRE2_CONFIG_JIT,(&mut jit as *mut u32).cast::<c_void>())};
 println!("PCRE2_CONFIG_JIT_RC={rc}");
 println!("PCRE2_CONFIG_JIT={jit}");
}
RS
export CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_LINKER=musl-gcc
export CC_aarch64_unknown_linux_musl=musl-gcc
cd "$WORK/probe" || exit 0
cargo run --release --target aarch64-unknown-linux-musl
RC=$?
echo '=== FINAL SUMMARY ==='
echo "RUN_RC=$RC"
echo 'EXPECTED_STOCK_PCREE2_CONFIG_JIT=0'
if [ "$RC" -eq 0 ]; then echo 'REPRODUCTION=PASS'; else echo 'REPRODUCTION=FAIL'; fi
