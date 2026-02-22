const std = @import("std");
const bwapi = @import("bwapi_module.zig");
const bw = @import("bwenums.zig");
const events = @import("events.zig");
const GameState = @import("GameState.zig");
const Task = @import("task.zig").Task;
const Directive = @import("directive.zig");

pub fn onFrame(Broodwar: ?*bwapi.Game, allocator: std.mem.Allocator, game_state: ?*GameState) void {
    const state_ptr: *GameState = game_state orelse unreachable;
    var new_events = std.array_list.Managed(events.UnitEvent).init(allocator);
    defer new_events.deinit();

    //debug
    drawDebugInfo(Broodwar);

    //gather events
    events.gatherEvents(&new_events, Broodwar) catch unreachable;

    //update gamestate
    state_ptr.updateGameStateFromEvents(new_events, Broodwar);

    //find new things to do
    const new_directives = state_ptr.getNewDirectives(allocator, Broodwar) catch |err| {
        std.debug.print("Error determining active directives: {}", .{@intFromError(err)});
        return;
    };
    defer allocator.free(new_directives);

    //create tasks from new things

    //state_ptr.identify_battles(Broodwar)

    //init list of tasks to perform at end of function

    //update priorities based on gamestate

    //priority list = get priorities from gamestate

    //issue commands based on priority
    //commands to issue = priorities + gamestate

    //execute commands

}

fn drawDebugInfo(Broodwar: ?*bwapi.Game) void {
    const frame_count: c_int = bwapi.Game_getFrameCount(Broodwar);
    const COORD_TYPE_NONE: bwapi.CoordinateType = .{ .id = 0 };
    bwapi.Game_drawText(Broodwar, COORD_TYPE_NONE, 10, 10, "Frame %d", frame_count);
}
