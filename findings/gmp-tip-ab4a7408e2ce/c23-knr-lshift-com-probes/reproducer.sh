#!/usr/bin/env bash

GCC="${GCC:-gcc}"
CLANG="${CLANG:-clang}"

WORK="${TMPDIR:-/tmp}/gmp-knr-c23-$$"
rm -rf "$WORK"
mkdir -p "$WORK"

cat >"$WORK/knr.c" <<'SRC'
unsigned long
lshift_com (rp, up, n, cnt)
  unsigned long *rp;
  unsigned long *up;
  long n;
  unsigned cnt;
{
  (void) rp;
  (void) up;
  (void) n;
  (void) cnt;
  return 0;
}

int
main (void)
{
  unsigned long a = 0;
  return (int) lshift_com (&a, &a, 1, 1);
}
SRC

cat >"$WORK/prototype.c" <<'SRC'
unsigned long
lshift_com (unsigned long *rp,
            unsigned long *up,
            long n,
            unsigned cnt)
{
  (void) rp;
  (void) up;
  (void) n;
  (void) cnt;
  return 0;
}

int
main (void)
{
  unsigned long a = 0;
  return (int) lshift_com (&a, &a, 1, 1);
}
SRC

"$GCC" -O2 -std=gnu17 "$WORK/knr.c" -o "$WORK/gcc17" \
  >"$WORK/gcc17.log" 2>&1
gcc17=$?

"$GCC" -O2 -std=gnu23 "$WORK/knr.c" -o "$WORK/gcc23" \
  >"$WORK/gcc23.log" 2>&1
gcc23=$?

"$CLANG" -O2 -std=gnu17 "$WORK/knr.c" -o "$WORK/clang17" \
  >"$WORK/clang17.log" 2>&1
clang17=$?

"$CLANG" -O2 -std=gnu23 "$WORK/knr.c" -o "$WORK/clang23" \
  >"$WORK/clang23.log" 2>&1
clang23=$?

"$GCC" -O2 -std=gnu23 "$WORK/prototype.c" -o "$WORK/gcc-proto23" \
  >"$WORK/gcc-proto23.log" 2>&1
gcc_proto23=$?

"$CLANG" -O2 -std=gnu23 "$WORK/prototype.c" -o "$WORK/clang-proto23" \
  >"$WORK/clang-proto23.log" 2>&1
clang_proto23=$?

echo "GCC_KR_GNU17_RC=$gcc17"
echo "GCC_KR_GNU23_RC=$gcc23"
echo "CLANG_KR_GNU17_RC=$clang17"
echo "CLANG_KR_GNU23_RC=$clang23"
echo "GCC_PROTOTYPE_GNU23_RC=$gcc_proto23"
echo "CLANG_PROTOTYPE_GNU23_RC=$clang_proto23"

echo
echo '=== GCC GNU23 ==='
cat "$WORK/gcc23.log"

echo
echo '=== CLANG GNU23 ==='
cat "$WORK/clang23.log"

RESULT=0
[ "$gcc17" = 0 ] || RESULT=1
[ "$clang17" = 0 ] || RESULT=1
[ "$clang23" != 0 ] || RESULT=1
[ "$gcc_proto23" = 0 ] || RESULT=1
[ "$clang_proto23" = 0 ] || RESULT=1

if [ "$RESULT" = 0 ]; then
  echo 'REPRODUCER=PASS'
else
  echo 'REPRODUCER=FAIL'
fi

rm -rf "$WORK"
exit "$RESULT"
