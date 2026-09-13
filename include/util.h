#pragma once
/* Small helpers that replace the pieces of the Zig standard library the bot used:
 * a growable array, an int-keyed hash map and a logging macro. */

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

/* ---- logging (replaces std.debug.print) ---- */
#define LOG(...) do { fprintf(stderr, "[oscar] " __VA_ARGS__); fflush(stderr); } while (0)

/* ---- growable array (replaces std.ArrayList) ----
 * Declare a type with   typedef VEC(Foo) FooVec;
 * Zero-initialise it, push with vec_push, free with vec_free. */
#define VEC(T) struct { T* items; size_t len, cap; }

int vec_reserve_(void** items, size_t* cap, size_t need, size_t elem_size);

#define vec_push(v, item) \
    (vec_reserve_((void**)&(v)->items, &(v)->cap, (v)->len + 1, sizeof(*(v)->items)) \
        ? -1 : ((v)->items[(v)->len++] = (item), 0))

#define vec_clear(v) ((v)->len = 0)
#define vec_free(v)  (free((v)->items), (v)->items = NULL, (v)->len = (v)->cap = 0)

/* ---- int -> value hash map (replaces std.AutoHashMap(c_int, V)) ----
 * Open addressing with linear probing. Values are stored inline as raw bytes. */
typedef struct IntMap {
    int*           keys;
    unsigned char* states;   /* 0 empty, 1 used, 2 tombstone */
    void*          values;
    size_t         value_size;
    size_t         cap;      /* power of two */
    size_t         len;      /* live entries */
    size_t         used;     /* live + tombstones */
} IntMap;

void  intmap_init(IntMap* m, size_t value_size);
void  intmap_free(IntMap* m);
/* Copies value_size bytes from value. Returns 0 on success, -1 on allocation failure. */
int   intmap_put(IntMap* m, int key, const void* value);
/* Pointer to the stored value, or NULL. Invalidated by the next intmap_put. */
void* intmap_get(IntMap* m, int key);
/* Returns 1 if an entry was removed, 0 if the key was absent. */
int   intmap_remove(IntMap* m, int key);
/* Iteration: start with i = 0; returns pointer to next value or NULL when done. */
void* intmap_next(IntMap* m, size_t* i, int* key_out);
