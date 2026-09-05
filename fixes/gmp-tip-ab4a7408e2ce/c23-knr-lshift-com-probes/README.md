# GMP ab4a7408e2ce C23 lshift_com validated fix

Status: **VALIDATED FIX**

Related finding:

`findings/gmp-tip-ab4a7408e2ce/c23-knr-lshift-com-probes`

Finding commit:

`60de53223aab7cbdc34208ce7c5484a1903cc268`

## Problem

Two configure probes use old-style K&R definitions of `lshift_com`.
The tested Clang accepts the form in GNU17 mode but rejects it in GNU23.

## Fix

Both definitions are converted to modern prototypes.

Patch scope is limited to:

`acinclude.m4`

## Validation

The targeted configure matrix passed under GCC and Clang.

Full GNU23 builds and `make check` passed under:

- GCC
- Clang

True test failures: **0**

The patch artefact was normalized before publication after
`git diff --check` detected trailing whitespace.

Revalidation required after normalization: **NO**

Normalized patch revalidation: **NOT_REQUIRED**

## Upstream

Status: **NOT_SUBMITTED**
