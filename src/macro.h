#pragma once
/* Macro (economy/build) helpers. */

#include "Game.h"
#include "bwenums.h"
#include "directive.h"
#include "gamestate.h"

/* if cur_builder succeeded, should delete itself
 * if cur_builder no longer working we reassign it */
typedef struct BuildTracker {
    uint32_t       build_id;
    int            cur_builder;  /* -1 for none/awaiting reassignment */
    UnitTypeId     type;
    TargetLocation location;
} BuildTracker;

/* Called exactly once per desired building. Returns a tracker that is added to
 * gamestate; the tracker must be handled elsewhere to get the build done. */
BuildTracker macro_init_build(UnitTypeId unit_type, TargetLocation location, GameState* gs, Game* broodwar);
