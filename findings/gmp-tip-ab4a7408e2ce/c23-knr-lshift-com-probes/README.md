# GMP upstream tip: C23-incompatible old-style `lshift_com` configure probes

## Summary

The recorded GNU GMP upstream tip contains two `mpn_lshift_com` configure
probes using an old-style K&R function definition:

    lshift_com (rp, up, n, cnt)
      unsigned long *rp;
      unsigned long *up;
      long n;
      unsigned cnt;

The extracted construct is accepted by the tested Clang in GNU17 mode but is
rejected in GNU23 mode.

An equivalent prototype definition compiles successfully in GNU23 mode.

## Evidence

See:

- `environment.txt`
- `results.txt`
- `reproducer.sh`
- `logs/reproducer.log`
- `logs/upstream-tip-identity.txt`
- `logs/upstream-source-context.txt`

## Scope

This finding concerns C23 source-language compatibility of configure probes.

It does not claim:

- an arithmetic defect;
- an `mpn_lshift_com` runtime defect;
- an AArch64-specific defect.

## Upstream

Status: **NOT_SUBMITTED**

No patch or correction is included in this finding.

Any patch candidate and validation evidence must remain under a separate
`fixes/` tree and separate Git commit.

## Validated fix

A validated correction has been published separately.

Path:

`fixes/gmp-tip-ab4a7408e2ce/c23-knr-lshift-com-probes`

Validated fix commit:

`e4dbdd2f5b203f77e2bcac62130af4b41d8bd98a`

Validation status:

- GCC GNU23 build/check: PASS
- Clang GNU23 build/check: PASS
- true test failures: 0
- non-regression: PASS

Upstream status:

`NOT_SUBMITTED`
