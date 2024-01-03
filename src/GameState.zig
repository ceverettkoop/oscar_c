const std = @import("std");
const GameState = @This();
const bwapi = @import("bwapi_module.zig");
const bw = @import("bwenums.zig");
const events = @import("events.zig");

//members
unit_list: std.ArrayList(UnitRecord),
self_player_id: c_int,
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

const UnitRecord = struct { 
    id: c_int, 
    type: bw.UnitType, 
    is_friendly: bool, 
    role: UnitRole, 
    role_verified: bool 
};

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

pub fn updateGameStateFromEvents(self: *GameState, 
    new_events: std.ArrayList(events.UnitEvent), Broodwar: ?*bwapi.Game) void{
    const EventType = events.EventType;
    for (new_events.items) |event| {
        switch (event.type) {
            //have to handle unit registration failure here so not passed up to toframe
            EventType.UnitCreate => registerNewUnit(self, event, Broodwar),
            else => continue,
        }
    }

}

//called if/when we are sure a unit is new to us
fn registerNewUnit(self: *GameState, event: events.UnitEvent, Broodwar: ?*bwapi.Game) !void{
    //todo throw more expressive error, but this will just abort registration
    const unit_ptr = try bwapi.Game_getUnit(Broodwar, event.unit_id);
    const unit_owner = try bwapi.Unit_getPlayer(unit_ptr);

    const new_unit: UnitRecord = .{
        .id = event.unit_id,
        .type = @enumFromInt(bwapi.Unit_getType(unit_ptr).id),
        .is_friendly = (bwapi.Player_getID(unit_owner) == self.self_player_id),
        .role = UnitRole.UNKNOWN,
        .role_verified = false,
    };
    self.unit_list.append(new_unit);
}
