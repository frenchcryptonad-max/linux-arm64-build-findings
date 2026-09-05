# GMP 6.3.0 C23 configure-probe incompatibility

GNU GMP 6.3.0 contains a compiler reliability probe defining:

    void g(){}

and subsequently invokes `g` with arguments.

On the recorded Linux AArch64 environment:

| Mode | Result |
|---|---|
| GCC default | FAIL |
| GCC GNU17 | PASS |
| GCC GNU23 | FAIL |
| Clang GNU17 | PASS |
| Clang GNU23 | FAIL |

This isolates a C23 compatibility problem in the GMP 6.3.0 configure probe.

AArch64 is the reproduction environment and is not established as the cause.
GMP arithmetic and `mpn` are not implicated.

Upstream status: ACCEPTED

Known upstream changeset:

    8e7bb4ae7a18

The correction is intentionally excluded. Fix validation belongs in a separate
`fixes/` tree and separate commit.
