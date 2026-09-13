#include "macro.h"

#include "Unit.h"

/* naive attempt to build without tracking, tracker just holds
 * parameters for what we are trying to do */
static void build(BuildTracker track, Game* broodwar)
{
    Unit* unit = Game_getUnit(broodwar, track.cur_builder);
    if (!unit) {
        LOG("Error getting unit_ptr on call to macro build\n");
        return;
    }
    UnitTypeId builder_type = WhatBuilds[track.type];
    if (builder_type != UT_Zerg_Drone) {
        /* if we are just upgrading, just see if it's possible per bwapi */
        UnitType target = { track.type };
        if (Unit_canMorph_UnitType(unit, target, true, true)) {
            /* TODO queue this command to execute at end of frame somehow */
            Unit_morph(unit, target); /* gamestate will check if we succeeded */
        }
        return; /* building to building up but not possible */
    }
    /* TODO: needs to be built by a drone at a legal location */
}

BuildTracker macro_init_build(UnitTypeId unit_type, TargetLocation location, GameState* gs, Game* broodwar)
{
    static uint32_t next_id = 0;
    BuildTracker tracker = {
        .build_id = next_id++,
        .cur_builder = -1, /* defaults to invalid */
        .type = unit_type,
        .location = location,
    };
    UnitTypeId builder_type = WhatBuilds[unit_type];

    /* iterate through known unit records for an eligible builder */
    size_t i = 0;
    UnitRecord* rec;
    while ((rec = intmap_next(&gs->unit_list, &i, NULL))) {
        if (rec->type != builder_type || !rec->is_friendly) continue;
        switch (rec->role) {
        case ROLE_SCOUT:
        case ROLE_ARMY:
        case ROLE_BUILDER: /* this has to be set/unset properly! */
            continue;
        default:
            break;
        }
        tracker.cur_builder = rec->id;
        break;
    }
    /* early exit on failure, build to be picked up later */
    if (tracker.cur_builder == -1) return tracker;

    build(tracker, broodwar); /* initial call to build */
    return tracker;
}
