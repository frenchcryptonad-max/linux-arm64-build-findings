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
