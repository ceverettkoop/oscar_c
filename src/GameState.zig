const std = @import("std");
const GameState = @This();
const ArrayList = std.ArrayList;
const bwapi = @import("bwapi_module.zig");
const bw = @import("bwenums.zig");

//members
unit_list: ArrayList(UnitRecord),
self_race: bw.Race = bw.Race.Unknown,
enemy_race: bw.Race = bw.Race.Unknown,

//definitions
const UnitRole = enum{
    MINER,
    GAS_GATHER,
    BUILDER,
    SCOUT,
    ARMY,
    UNKNOWN
};

const UnitRecord = struct{
    id: c_int,
    type: bw.UnitType,
    is_friendly: bool,
    role: UnitRole,
    role_verified: bool
};

pub fn init(self: *GameState, allocator: std.mem.Allocator, Broodwar: ?*bwapi.Game)void{
    //allocations
    self.unit_list = ArrayList(UnitRecord).init(allocator);
    //determine races
    const me = bwapi.Game_self(Broodwar);
    const enemy = bwapi.Game_enemy(Broodwar);
    self.self_race = @as(bw.Race, bwapi.Player_getRace(me).id);
    self.enemy_race = @as(bw.Race, bwapi.Player_getRace(enemy).id);
}

pub fn deinit(self: *GameState) void{
    self.unit_list.deinit();
}

