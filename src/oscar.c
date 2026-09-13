#include "oscar.h"

#include "events.h"

static void draw_debug_info(Game* broodwar)
{
    CoordinateType coord_none = { 0 };
    Game_drawText(broodwar, coord_none, 10, 10, "Frame %d", Game_getFrameCount(broodwar));
}

void oscar_on_frame(Game* broodwar, GameState* gs)
{
    UnitEventVec new_events = {0};

    draw_debug_info(broodwar);

    /* gather events */
    if (gather_events(&new_events, broodwar)) LOG("out of memory gathering events\n");

    /* update gamestate */
    gamestate_update_from_events(gs, &new_events, broodwar);

    /* find newly applicable directives, generate tasks based on these
     * (this also marks those directives as in progress) */
    if (gamestate_update_tasks_from_directives(gs, broodwar)) LOG("Error updating task list\n");

    /* TODO
     * gs.identify_battles(broodwar)
     * update priorities based on gamestate
     * issue commands based on priority (priorities + gamestate)
     * execute queued commands */

    vec_free(&new_events);
}
