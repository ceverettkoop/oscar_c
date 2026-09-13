#pragma once
/* Everything the bot remembers between frames. */

#include "Game.h"
#include "bwenums.h"
#include "directive.h"
#include "events.h"
#include "task.h"
#include "util.h"

typedef enum UnitRole { ROLE_MINER, ROLE_GAS_GATHER, ROLE_BUILDER, ROLE_SCOUT, ROLE_ARMY, ROLE_UNKNOWN } UnitRole;

/* weighted random selection */
typedef enum Strategy { STRAT_FOUR_POOL, STRAT_OGRE_ZERG } Strategy;

typedef struct UnitRecord {
    int        id;
    UnitTypeId type;
    bool       is_friendly;
    bool       is_visible;
    UnitRole   role;
    bool       role_verified;
} UnitRecord;

typedef VEC(Directive)  DirectiveVec;
typedef VEC(Directive*) DirectivePtrVec;
typedef VEC(Task)       TaskVec;

typedef struct GameState {
    IntMap          unit_list;       /* unit id -> UnitRecord */
    DirectiveVec    directive_list;
    TaskVec         task_list;
    int             self_player_id;
    int             self_race;
    int             enemy_race;
} GameState;

void gamestate_init(GameState* gs, Game* broodwar);
void gamestate_deinit(GameState* gs);

/* Applies unit create/morph/destroy/show/hide events to the unit table. */
void gamestate_update_from_events(GameState* gs, const UnitEventVec* events, Game* broodwar);

/* Finds inactive directives whose prerequisite is now met, marks them in progress
 * and (TODO) generates tasks for them. Returns 0 on success. */
int gamestate_update_tasks_from_directives(GameState* gs, Game* broodwar);

/* Collects newly satisfied directives into *out and marks them IN_PROGRESS. */
int gamestate_get_active_directives(GameState* gs, DirectivePtrVec* out, Game* broodwar);

UnitRecord* gamestate_find_unit(GameState* gs, int unit_id);
