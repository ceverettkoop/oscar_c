const std = @import("std");
const bw = @import("bwenums.zig");
const bwapi = @import("bwapi_module.zig");

const Task = struct{
    priority: u16 = 0,
    unit_ptr: *bwapi.Unit,
    unit_command: bwapi.UnitCommand
};