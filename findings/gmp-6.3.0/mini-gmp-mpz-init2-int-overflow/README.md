# GMP 6.3.0 Mini-GMP mpz_init2 allocation metadata overflow

Status: FINDING

Component: GNU GMP 6.3.0 / mini-gmp/mini-gmp.c
Function: mpz_init2
Architecture reproduced: AArch64 / LP64

## Summary

mini-gmp mpz_init2 computes the requested limb count in mp_size_t,
which is 64-bit on the reproduced platform, then stores that value
directly into the 32-bit int field _mp_alloc without a range check.

At INT_MAX+1 limbs, _mp_alloc becomes INT_MIN.
A subsequent mpz_clear therefore supplies an incorrect size to the
registered free callback.

## Expected

A request exceeding the representable mpz allocation metadata range
must be rejected before _mp_alloc is narrowed.

The full GMP 6.3.0 mpz/init2.c implementation performs an
explicit new_alloc > INT_MAX overflow check.

## Observed

EXPECTED_LIMBS=2147483648
STORED__mp_alloc=-2147483648
ALLOC_METADATA_MATCH=NO
FREE_SIZE_MATCH=NO

The behavior reproduced with both GCC and Clang.

## Scope

Established for GMP 6.3.0 Mini-GMP on the tested AArch64 LP64 system.
No claim is yet made for every architecture or every upstream revision.

## Fix

No fix is included in this finding.
Any patch candidate must be developed and validated separately.
