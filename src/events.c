#include "events.h"

#include "Iterator.h"
#include "Unit.h"

static bool is_unit_related(EventTypeId t)
{
    switch (t) {
    case EV_UnitComplete: case EV_UnitCreate: case EV_UnitDestroy:
    case EV_UnitDiscover: case EV_UnitEvade:  case EV_UnitHide:
    case EV_UnitMorph:    case EV_UnitRenegade: case EV_UnitShow:
        return true;
    default:
        return false;
    }
}

int gather_events(UnitEventVec* out, Game* broodwar)
{
    Iterator* it = (Iterator*)Game_getEvents(broodwar);
    if (!it) return 0;

    int rc = 0;
    for (; Iterator_valid(it); Iterator_next(it)) {
        const Event* ev = Iterator_get(it);
        EventTypeId type = (EventTypeId)ev->type.id;
        if (!is_unit_related(type)) continue;

        UnitEvent ue = { type, Unit_getID(ev->unit) };
        if (vec_push(out, ue)) { rc = -1; break; }
    }
    Iterator_release(it);
    return rc;
}
