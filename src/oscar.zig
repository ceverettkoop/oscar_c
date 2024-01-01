const std = @import("std");
const bwapi = @import("bwapi_module.zig");
const events = @import("events.zig");
const ArrayList = std.ArrayList;
const Alloc = std.heap.GeneralPurposeAllocator(.{}){};


pub fn onFrame(Broodwar: ?*bwapi.Game) void{
    const frame_count: c_int = bwapi.Game_getFrameCount(Broodwar);
    const COORD_TYPE_NONE: bwapi.CoordinateType = .{.id = 0};
    bwapi.Game_drawText(Broodwar, COORD_TYPE_NONE, 
        10, 10, "HELLO FROM ZIG Frame %d", frame_count);

    var new_events = ArrayList(events.UnitEvent).init(Alloc);
    defer new_events.deinit();
    



}