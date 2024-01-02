const std = @import("std");
const bwapi = @import("bwapi_module.zig");
const bw = @import("bwenums.zig");
const events = @import("events.zig");
const GameState = @import("GameState.zig");
const ArrayList = std.ArrayList;

pub fn onFrame(Broodwar: ?*bwapi.Game, allocator: std.mem.Allocator) void {

    //start timer

    //debug
    drawDebugInfo(Broodwar);

    //gather events
    var new_events = ArrayList(events.UnitEvent).init(allocator);
    defer new_events.deinit();
    events.gatherEvents(&new_events, Broodwar) catch unreachable;
    //update gamestate

}

fn drawDebugInfo(Broodwar: ?*bwapi.Game) void {
    const frame_count: c_int = bwapi.Game_getFrameCount(Broodwar);
    const COORD_TYPE_NONE: bwapi.CoordinateType = .{ .id = 0 };
    bwapi.Game_drawText(Broodwar, COORD_TYPE_NONE, 10, 10, "Frame %d", frame_count);
}
