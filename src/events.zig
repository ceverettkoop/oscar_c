const std = @import("std");
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