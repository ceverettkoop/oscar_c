const std = @import("std");
const bw = @import("bwenums.zig");
const bwapi = @import("bwapi_module.zig");
const Directive = @import("directive.zig").Directive;

pub const Task = struct { 
    unit_ptr: *bwapi.Unit, 
    unit_command: bwapi.UnitCommand,
    origin_directive: *Directive
};
