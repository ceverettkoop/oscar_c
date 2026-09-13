#include "gamestate.h"

#include "Player.h"
#include "Unit.h"

typedef enum BwapiError { BW_OK = 0, BW_UNIT_NOT_FOUND, BW_UNIT_RECORD_NOT_FOUND } BwapiError;

void gamestate_init(GameState* gs, Game* broodwar)
{
    intmap_init(&gs->unit_list, sizeof(UnitRecord));
    gs->directive_list = (DirectiveVec){0};
    gs->task_list = (TaskVec){0};

    Player* me = Game_self(broodwar);
    Player* enemy = Game_enemy(broodwar);
    gs->self_player_id = Player_getID(me);
    gs->self_race = Player_getRace(me).id;
    gs->enemy_race = enemy ? Player_getRace(enemy).id : RACE_Unknown;
}

void gamestate_deinit(GameState* gs)
{
    intmap_free(&gs->unit_list);
    vec_free(&gs->directive_list);
    vec_free(&gs->task_list);
}

UnitRecord* gamestate_find_unit(GameState* gs, int unit_id)
{
    return intmap_get(&gs->unit_list, unit_id);
}

/* called once we are sure a unit is new to us */
static BwapiError register_new_unit(GameState* gs, UnitEvent ev, Game* broodwar)
{
    Unit* unit = Game_getUnit(broodwar, ev.unit_id);
    if (!unit) return BW_UNIT_NOT_FOUND;
    Player* owner = Unit_getPlayer(unit);

    UnitRecord rec = {
        .id = ev.unit_id,
        .type = (UnitTypeId)Unit_getType(unit).id,
        .is_friendly = owner && Player_getID(owner) == gs->self_player_id,
        .is_visible = true,
        .role = ROLE_UNKNOWN,
        .role_verified = false,
    };
    if (intmap_put(&gs->unit_list, rec.id, &rec)) {
        LOG("out of memory registering unit %d\n", rec.id);
    }
    return BW_OK;
}

/* updates type and ownership on morph/renegade (geyser -> extractor changes both) */
static BwapiError update_unit_type(GameState* gs, UnitEvent ev, Game* broodwar)
{
    Unit* unit = Game_getUnit(broodwar, ev.unit_id);
    if (!unit) return BW_UNIT_NOT_FOUND;
    UnitRecord* rec = gamestate_find_unit(gs, ev.unit_id);
    if (!rec) return BW_UNIT_RECORD_NOT_FOUND;
    Player* owner = Unit_getPlayer(unit);
    rec->type = (UnitTypeId)Unit_getType(unit).id;
    rec->is_friendly = owner && Player_getID(owner) == gs->self_player_id;
    return BW_OK;
}

static BwapiError rm_unit(GameState* gs, UnitEvent ev)
{
    return intmap_remove(&gs->unit_list, ev.unit_id) ? BW_OK : BW_UNIT_RECORD_NOT_FOUND;
}

static void set_visible(GameState* gs, UnitEvent ev, bool visible, const char* what)
{
    UnitRecord* rec = gamestate_find_unit(gs, ev.unit_id);
    if (!rec) { LOG("UnitRecordNotFound on %s (id %d)\n", what, ev.unit_id); return; }
    rec->is_visible = visible;
}

/* not handling nuke detect or system messages */
void gamestate_update_from_events(GameState* gs, const UnitEventVec* events, Game* broodwar)
{
    for (size_t i = 0; i < events->len; i++) {
        UnitEvent ev = events->items[i];
        BwapiError err;
        switch (ev.type) {
        case EV_UnitCreate:
        case EV_UnitDiscover:
            err = register_new_unit(gs, ev, broodwar);
            if (err == BW_UNIT_NOT_FOUND) LOG("UnitNotFound error on registration (id %d)\n", ev.unit_id);
            break;
        case EV_UnitMorph:
        case EV_UnitRenegade:
            err = update_unit_type(gs, ev, broodwar);
            if (err == BW_UNIT_NOT_FOUND) LOG("UnitNotFound error on morph (id %d)\n", ev.unit_id);
            if (err == BW_UNIT_RECORD_NOT_FOUND) LOG("UnitRecordNotFound on morph (id %d)\n", ev.unit_id);
            break;
        case EV_UnitDestroy:
            err = rm_unit(gs, ev);
            if (err == BW_UNIT_RECORD_NOT_FOUND) LOG("UnitRecordNotFound on remove (id %d)\n", ev.unit_id);
            break;
        case EV_UnitHide:
            set_visible(gs, ev, false, "hide");
            break;
        case EV_UnitShow:
            set_visible(gs, ev, true, "show");
            break;
        default:
            break;
        }
    }
}

int gamestate_get_active_directives(GameState* gs, DirectivePtrVec* out, Game* broodwar)
{
    Player* me = Game_self(broodwar);
    Race race = { gs->self_race };

    for (size_t i = 0; i < gs->directive_list.len; i++) {
        Directive* dir = &gs->directive_list.items[i];
        if (dir->status != STATUS_INACTIVE) continue;
        /* TODO logic to revisit certain done ones. rn done is done */

        bool satisfied = false;
        switch (dir->prereq.type) {
        case PREREQ_AI_FLAG:
            break; /* TODO flags not implemented */
        case PREREQ_SUPPLY:
            satisfied = Player_supplyUsed(me, race) == dir->prereq.qty;
            break;
        case PREREQ_TIMESTAMP:
            satisfied = Game_elapsedTime(broodwar) >= dir->prereq.qty;
            break;
        case PREREQ_UNIT_QTY:
            break; /* TODO count units of prereq.value in unit_list */
        default:
            break;
        }
        if (!satisfied) continue;

        if (vec_push(out, dir)) return -1;
        dir->status = STATUS_IN_PROGRESS;
    }
    return 0;
}

int gamestate_update_tasks_from_directives(GameState* gs, Game* broodwar)
{
    DirectivePtrVec new_dirs = {0};
    int rc = gamestate_get_active_directives(gs, &new_dirs, broodwar);
    if (rc == 0) {
        for (size_t i = 0; i < new_dirs.len; i++) {
            Directive* dir = new_dirs.items[i];
            /* TODO create tasks linked to this directive and append to gs->task_list */
            Game_printf(broodwar, "directive active: %s %d %s",
                        dir->command.type == CMD_BUILD ? "BUILD" : "CMD",
                        dir->command.target_qty, UnitTypeNames[dir->command.target_type]);
        }
    }
    vec_free(&new_dirs);
    return rc;
}
