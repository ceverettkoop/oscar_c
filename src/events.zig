const std = @import("std");
const ArrayList = std.ArrayList;
const bwapi = @import("bwapi_module.zig");

const EventType = enum(c_int) {
    MatchStart,
    MatchEnd,
    MatchFrame,
    MenuFrame,
    SendText,
    ReceiveText,
    PlayerLeft,
    NukeDetect,
    UnitDiscover,
    UnitEvade,
    UnitShow,
    UnitHide,
    UnitCreate,
    UnitDestroy,
    UnitMorph,
    UnitRenegade,
    SaveGame,
    UnitComplete,
    None
};

pub const UnitEvent = struct{
    type: EventType,
    unit_id: c_int,
};

pub fn gatherEvents(event_list: ?*ArrayList(UnitEvent), Broodwar: ?*bwapi.Game) !void{

    var event_it: *bwapi.Iterator = @ptrCast(bwapi.Game_getEvents(Broodwar).? ) ;

    while(bwapi.Iterator_valid(event_it)){
        const aligned_ptr: *align(4)anyopaque = @alignCast(bwapi.Iterator_get(event_it).?);
        const event: *bwapi.Event = @ptrCast(aligned_ptr);
        const event_type: EventType = @enumFromInt(event.type.id);
        var unit_related: bool = switch (event_type) {
            EventType.UnitComplete, EventType.UnitCreate, EventType.UnitDestroy,
            EventType.UnitDiscover, EventType.UnitEvade, EventType.UnitHide,
            EventType.UnitMorph, EventType.UnitRenegade, EventType.UnitShow
                => true,
            else => false,
        };
        //ignore events not pertaining to unit
        if (!unit_related) continue;
        const new_event: UnitEvent = .{.type = @as(EventType, event_type)
            , .unit_id = bwapi.Unit_getID(event.unit)};
        const event_ptr = event_list.?;
        try event_ptr.*.append(new_event);
        bwapi.Iterator_next(event_it);
    }
}