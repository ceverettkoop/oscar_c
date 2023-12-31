#ifndef MEMORY_H
#define MEMORY_H

#include "stdint.h"

//goal is for state to be stored in a very small amount of memory

//how we know a unit exists
typedef struct UnitLog_{
    int id;
    uint8_t type;
}UnitLog;


#endif /* MEMORY_H */
