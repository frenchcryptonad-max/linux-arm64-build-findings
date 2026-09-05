#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>
#include <limits.h>
#include <sys/mman.h>
#include "mini-gmp.h"

static void *mapped_ptr;
static size_t mapped_len;
static size_t alloc_requested;
static size_t free_reported;
static int map_ok;

static void *test_alloc(size_t n)
{
  void *p;
  alloc_requested = n;
  p = mmap(NULL, n, PROT_READ | PROT_WRITE,
           MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
  if (p == MAP_FAILED) {
    map_ok = 0;
    return NULL;
  }
  map_ok = 1;
  mapped_ptr = p;
  mapped_len = n;
  return p;
}

static void *test_realloc(void *p, size_t oldn, size_t newn)
{
  (void)p; (void)oldn; (void)newn;
  abort();
}

static void test_free(void *p, size_t n)
{
  free_reported = n;
  if (p == mapped_ptr && mapped_ptr != NULL)
    munmap(mapped_ptr, mapped_len);
  mapped_ptr = NULL;
}

int main(void)
{
  mpz_t z;
  const uint64_t expected_limbs = (uint64_t)INT_MAX + 1ULL;
  const mp_bitcnt_t bits =
    (mp_bitcnt_t)INT_MAX *
    (mp_bitcnt_t)(sizeof(mp_limb_t) * CHAR_BIT) + 1;

  mp_set_memory_functions(test_alloc, test_realloc, test_free);

  printf("INT_MAX=%d\n", INT_MAX);
  printf("sizeof_mp_size_t=%zu\n", sizeof(mp_size_t));
  printf("sizeof__mp_alloc=%zu\n", sizeof(z[0]._mp_alloc));
  printf("REQUEST_BITS=%lu\n", (unsigned long)bits);
  printf("EXPECTED_LIMBS=%llu\n",
         (unsigned long long)expected_limbs);

  mpz_init2(z, bits);

  printf("MAP_OK=%s\n", map_ok ? "YES" : "NO");
  printf("ALLOC_REQUEST_BYTES=%zu\n", alloc_requested);
  printf("STORED__mp_alloc=%d\n", z[0]._mp_alloc);
  printf("STORED__mp_size=%d\n", z[0]._mp_size);

  printf("ALLOC_METADATA_MATCH=%s\n",
         ((uint64_t)(uint32_t)z[0]._mp_alloc == expected_limbs
          && z[0]._mp_alloc >= 0) ? "YES" : "NO");

  if (!map_ok)
    return 77;

  mpz_clear(z);

  printf("FREE_REPORTED_BYTES=%zu\n", free_reported);
  printf("FREE_SIZE_MATCH=%s\n",
         free_reported == alloc_requested ? "YES" : "NO");

  return 0;
}
