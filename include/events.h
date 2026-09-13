#pragma once
/* Reduces BWAPI's per-frame event stream to the unit events the bot tracks. */

#include "Game.h"
#include "util.h"

/* Mirrors BWAPI::EventType::Enum ordering. */
typedef enum EventTypeId {
    EV_MatchStart, EV_MatchEnd, EV_MatchFrame, EV_MenuFrame, EV_SendText, EV_ReceiveText,
    EV_PlayerLeft, EV_NukeDetect, EV_UnitDiscover, EV_UnitEvade, EV_UnitShow, EV_UnitHide,
    EV_UnitCreate, EV_UnitDestroy, EV_UnitMorph, EV_UnitRenegade, EV_SaveGame, EV_UnitComplete,
    EV_None
} EventTypeId;

typedef struct UnitEvent {
    EventTypeId type;
    int         unit_id;
} UnitEvent;

typedef VEC(UnitEvent) UnitEventVec;

/* Appends this frame's unit-related events to *out. Returns 0 on success. */
int gather_events(UnitEventVec* out, Game* broodwar);
