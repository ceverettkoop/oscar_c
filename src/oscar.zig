const std = @import("std");
const bwapi = @import("bwapi_module.zig");

pub fn onFrame(Broodwar: ?*bwapi.Game) void{
    const frame_count: c_int = bwapi.Game_getFrameCount(Broodwar);
    const COORD_TYPE_NONE: bwapi.CoordinateType = .{.id = 0};
    bwapi.Game_drawText(Broodwar, COORD_TYPE_NONE, 
        10, 10, "HELLO FROM ZIG Frame %d", frame_count);
}