# Gnulib C++ namespace mode fails on `openat` with Clang 23 on Linux AArch64

## Summary

GNU M4 1.4.21 configured with C++ support exposes a reproducible C++ compilation failure when Gnulib namespace mode is enabled.

The failure occurs around:

```text
_GL_CXXALIASWARN (openat);
```

Clang reports:

```text
error: reference to overloaded function could not be resolved
```

The same reduced test succeeds with G++ 15.2.0.

## Environment

- Architecture: AArch64
- OS: Ubuntu 26.04.1 LTS
- Kernel family: Linux 7.0
- glibc: 2.43
- Clang/Clang++: 23.1.0
- GCC/G++: 15.2.0
- GNU M4: 1.4.21
- GNU M4 C++ support: enabled

## Reduced reproducer

```cpp
#define GNULIB_NAMESPACE gnulib
#include "config.h"
#include <fcntl.h>

int main()
{
  return 0;
}
```

Without `GNULIB_NAMESPACE`, the same source compiles successfully.

## Results

| Configuration | Result |
|---|---|
| No `GNULIB_NAMESPACE`, Clang 23 | PASS |
| `GNULIB_NAMESPACE`, Clang 23 | FAIL |
| `GNULIB_NAMESPACE`, Clang 23, `_FORTIFY_SOURCE` disabled | FAIL |
| Clang 23 / C++17 | FAIL |
| Clang 23 / C++20 | FAIL |
| Clang 23 / C++23 | FAIL |
| G++ 15.2 / C++23 | PASS |

## Scope

The current evidence shows a compiler-dependent compatibility issue involving Gnulib C++ namespace handling and `openat`.

It does not establish that:

- `openat()` itself is broken;
- `_FORTIFY_SOURCE=3` is the cause;
- C++23 is the cause;
- Linux AArch64 itself is the cause.

Further comparison with newer Gnulib snapshots and other Clang/glibc versions is appropriate before assigning the defect to a specific upstream component.

## License

This report and original reproduction scripts are provided under the repository license.

GNU M4, Gnulib, glibc, LLVM/Clang and GCC remain under their respective upstream licenses.
