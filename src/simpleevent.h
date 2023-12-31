#ifndef SIMPLEEVENT_H
#define SIMPLEEVENT_H

#include "stdint.h"

//BWAPI interrupts just add events to queue which is processed by bot, all events described here

typedef enum {
    UNIT_CREATE, //ignore for now as this is just ahead of unit complete?
    UNIT_COMPLETE,
    UNIT_MORPH,
    UNIT_DESTROYED,
    UNIT_SHOW,
    UNIT_HIDE,
    UNIT_RENEGADE
} SimpleEventType;

typedef struct SimpleEvent_{
    SimpleEventType e_type;
    int id;
    uint8_t type;
} SimpleEvent;

#endif /* SIMPLEEVENT_H */
