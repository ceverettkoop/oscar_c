#include "util.h"

#include <string.h>

int vec_reserve_(void** items, size_t* cap, size_t need, size_t elem_size)
{
    if (need <= *cap) return 0;
    size_t new_cap = *cap ? *cap : 8;
    while (new_cap < need) new_cap *= 2;
    void* p = realloc(*items, new_cap * elem_size);
    if (!p) return -1;
    *items = p;
    *cap = new_cap;
    return 0;
}

static size_t hash_int(int key, size_t cap)
{
    unsigned h = (unsigned)key * 2654435761u;
    return h & (cap - 1);
}

void intmap_init(IntMap* m, size_t value_size)
{
    memset(m, 0, sizeof *m);
    m->value_size = value_size;
}

void intmap_free(IntMap* m)
{
    free(m->keys);
    free(m->states);
    free(m->values);
    memset(m, 0, sizeof *m);
}

static int intmap_grow(IntMap* m)
{
    IntMap n;
    intmap_init(&n, m->value_size);
    n.cap = m->cap ? m->cap * 2 : 64;
    n.keys = calloc(n.cap, sizeof *n.keys);
    n.states = calloc(n.cap, sizeof *n.states);
    n.values = calloc(n.cap, m->value_size);
    if (!n.keys || !n.states || !n.values) { intmap_free(&n); return -1; }
    for (size_t i = 0; i < m->cap; i++) {
        if (m->states[i] != 1) continue;
        size_t j = hash_int(m->keys[i], n.cap);
        while (n.states[j]) j = (j + 1) & (n.cap - 1);
        n.states[j] = 1;
        n.keys[j] = m->keys[i];
        memcpy((char*)n.values + j * m->value_size, (char*)m->values + i * m->value_size, m->value_size);
        n.len++;
    }
    n.used = n.len;
    intmap_free(m);
    *m = n;
    return 0;
}

static size_t intmap_find(IntMap* m, int key)
{
    if (!m->cap) return (size_t)-1;
    size_t i = hash_int(key, m->cap);
    for (size_t probes = 0; probes < m->cap; probes++) {
        if (m->states[i] == 0) return (size_t)-1;
        if (m->states[i] == 1 && m->keys[i] == key) return i;
        i = (i + 1) & (m->cap - 1);
    }
    return (size_t)-1;
}

int intmap_put(IntMap* m, int key, const void* value)
{
    size_t at = intmap_find(m, key);
    if (at == (size_t)-1) {
        if ((m->used + 1) * 4 > m->cap * 3 && intmap_grow(m)) return -1;
        at = hash_int(key, m->cap);
        while (m->states[at] == 1) at = (at + 1) & (m->cap - 1);
        if (m->states[at] == 0) m->used++;
        m->states[at] = 1;
        m->keys[at] = key;
        m->len++;
    }
    memcpy((char*)m->values + at * m->value_size, value, m->value_size);
    return 0;
}

void* intmap_get(IntMap* m, int key)
{
    size_t at = intmap_find(m, key);
    return at == (size_t)-1 ? NULL : (char*)m->values + at * m->value_size;
}

int intmap_remove(IntMap* m, int key)
{
    size_t at = intmap_find(m, key);
    if (at == (size_t)-1) return 0;
    m->states[at] = 2;
    m->len--;
    return 1;
}

void* intmap_next(IntMap* m, size_t* i, int* key_out)
{
    for (; *i < m->cap; (*i)++) {
        if (m->states[*i] == 1) {
            if (key_out) *key_out = m->keys[*i];
            return (char*)m->values + (*i)++ * m->value_size;
        }
    }
    return NULL;
}
