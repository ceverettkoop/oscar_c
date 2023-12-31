#ifndef COMMANDS_H
#define COMMANDS_H

#include "stdint.h"

//at end of frame all commands in command queue are executed
//bot should vet that they are not contradictory or repeating

typedef struct SimpleCommand_{
    int unit_id;
    uint8_t type;
    int target_id_or_x;
    int target_y;
}SimpleCommand;

#endif /* COMMANDS_H */
