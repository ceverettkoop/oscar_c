const std = @import("std");
const GameState = @This();
const bwapi = @import("bwapi_module.zig");
const bw = @import("bwenums.zig");

//members
unit_list: std.ArrayList(UnitRecord),
self_race: c_int,
enemy_race: c_int,

//definitions
const UnitRole = enum { MINER, 
    GAS_GATHER, 
    BUILDER, 
    SCOUT, 
    ARMY, 
    UNKNOWN 
};

const UnitRecord = struct { id: c_int, type: bw.UnitType, is_friendly: bool, role: UnitRole, role_verified: bool };

pub fn init(self: *GameState, allocator: std.mem.Allocator, Broodwar: ?*bwapi.Game) void {
    //allocations
    self.unit_list = std.ArrayList(UnitRecord).init(allocator);
    //determine races
    const me = bwapi.Game_self(Broodwar);
    const enemy = bwapi.Game_enemy(Broodwar);
    self.self_race =  bwapi.Player_getRace(me).id;
    self.enemy_race = bwapi.Player_getRace(enemy).id;
}

pub fn deinit(self: *GameState) void {
    self.unit_list.deinit();
}
