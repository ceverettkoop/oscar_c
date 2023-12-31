#ifndef COMM_TYPES_H
#define COMM_TYPES_H

#include <stdint.h>

//notifications to AI from BW,
typedef enum{
    NOTE_NEW_FRAME, //signals a frma
    NOTE_UNIT_CREATE,
    NOTE_UNIT_DESTROY,
    NOTE_UNIT_DISCOVER
}NOTIFICATION_T;

//request from AI to BW
typedef enum{
    REQ_WORKER_COUNT,
    REQ_MARINE_COUNT,
    REQ_CC_COUNT,
    REQ_SUPPLY_USED,
    REQ_DEPOT_COUNT,
    REQ_START_LOCATION_COUNT,
    REQ_START_LOCATION_POINTS
}REQ_CODE_T;

typedef enum{
    
}COMMAND_T;

//categories of data that can be requested:


#endif /* COMM_TYPES_H */
