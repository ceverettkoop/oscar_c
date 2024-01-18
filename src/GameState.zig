//TODO UPDATE LAST COMMAND ON FRAME!!!!

const std = @import("std");
const GameState = @This();
const bwapi = @import("bwapi_module.zig");
const bw = @import("bwenums.zig");
const events = @import("events.zig");
const BWAPIError = error{
    UnitNotFound,
    UnitRecordNotFound
};

//members
unit_list: std.AutoHashMap(c_int, UnitRecord),
self_player_id: c_int,
self_race: c_int,
enemy_race: c_int,

//definitions
const UnitRole = enum { 
    MINER, 
    GAS_GATHER, 
    BUILDER, 
    SCOUT, 
    ARMY, 
    UNKNOWN 
};

//weighted random selection
const Strategy = enum{
    FOUR_POOL,
    OGRE_ZERG
};

const UnitRecord = struct { 
    id: c_int, 
    type: bw.UnitType, 
    is_friendly: bool,
    is_visible: bool,
    role: UnitRole, 
    role_verified: bool,
    last_command: bw.UnitCommandType
};

pub fn init(self: *GameState, allocator: std.mem.Allocator, Broodwar: ?*bwapi.Game) void {
    //allocations
    self.unit_list = std.AutoHashMap(c_int, UnitRecord).init(allocator);
    //determine races
    const me = bwapi.Game_self(Broodwar);
    const enemy = bwapi.Game_enemy(Broodwar);
    self.self_race =  bwapi.Player_getRace(me).id;
    self.enemy_race = bwapi.Player_getRace(enemy).id;
}

pub fn deinit(self: *GameState) void {
    self.unit_list.deinit();
}

//not handling nuke detect or system messages
pub fn updateGameStateFromEvents(self: *GameState, 
    new_events: std.ArrayList(events.UnitEvent), Broodwar: ?*bwapi.Game) void{
    const EventType = events.EventType;
    for (new_events.items) |event| {
        switch (event.type) {
            //have to handle unit registration failure here so not passed up to toframe
            EventType.UnitCreate => registerNewUnit(self, event, Broodwar) catch |err|{
                if (err == BWAPIError.UnitNotFound) std.debug.print("UnitNotFound error on registration\n", .{});
            },
            EventType.UnitDiscover => registerNewUnit(self, event, Broodwar) catch |err|{
                if (err == BWAPIError.UnitNotFound) std.debug.print("UnitNotFound error on registration\n", .{});
            },
            EventType.UnitMorph => updateUnitType(self, event, Broodwar) catch |err|{
                if (err == BWAPIError.UnitNotFound) std.debug.print("UnitNotFound error on morph\n", .{});
                if (err == BWAPIError.UnitRecordNotFound) std.debug.print("UnitRecordNotFound on morph\n", .{});
            },
            EventType.UnitRenegade => updateUnitType(self, event, Broodwar) catch |err|{
                if (err == BWAPIError.UnitNotFound) std.debug.print("UnitNotFound error on morph\n", .{});
                if (err == BWAPIError.UnitRecordNotFound) std.debug.print("UnitRecordNotFound on morph\n", .{});
            },
            EventType.UnitDestroy => rmUnit(self, event) catch |err|{
                if (err == BWAPIError.UnitRecordNotFound) std.debug.print("UnRecordNotFound on remove\n", .{});
            },
            EventType.UnitHide =>{
                const record = self.unit_list.getPtr(event.unit_id) orelse return std.debug.print("UnitRecordNotFound on hide\n", .{});
                record.is_visible = false;
            },
            EventType.UnitShow =>{
                const record = self.unit_list.getPtr(event.unit_id) orelse return std.debug.print("UnitRecordNotFound on show\n", .{});
                record.is_visible = true;
            },
            else => continue,
        }
    }
}

//called once we are sure a unit is new to us
fn registerNewUnit(self: *GameState, event: events.UnitEvent, Broodwar: ?*bwapi.Game) !void{
    //check if unit is found by id
    const unit_ptr = bwapi.Game_getUnit(Broodwar, event.unit_id);
    if (unit_ptr) |u_ptr_val|{
        const unit_owner = bwapi.Unit_getPlayer(u_ptr_val) orelse unreachable; //hard crash
        //create and append record
        const new_unit: UnitRecord = .{
            .id = event.unit_id,
            .type = @enumFromInt(bwapi.Unit_getType(unit_ptr).id),
            .is_visible = true,
            .is_friendly = (bwapi.Player_getID(unit_owner) == self.self_player_id),
            .role = UnitRole.UNKNOWN,
            .role_verified = false,
        };
        try self.unit_list.put(new_unit.id, new_unit);
    }else{
        //handle null unit ptr
        return BWAPIError.UnitNotFound;
    }
}

//only applicable for morph? updates type on unit per event
fn updateUnitType(self: *GameState, event: events.UnitEvent, Broodwar: ?*bwapi.Game) !void{
    //check if unit is found by id
    const unit_ptr = bwapi.Game_getUnit(Broodwar, event.unit_id);
    if (unit_ptr)|u_ptr_val|{
        //we have to check ownership as well as type specifically for geyser to extractor case
        const unit_owner = bwapi.Unit_getPlayer(u_ptr_val) orelse unreachable; //hard crash
        const record = self.unit_list.getPtr(event.unit_id) orelse return BWAPIError.UnitRecordNotFound;
        record.type = @enumFromInt(bwapi.Unit_getType(u_ptr_val).id);
        record.is_friendly = (bwapi.Player_getID(unit_owner) == self.self_player_id);
    }else{
        return BWAPIError.UnitNotFound;
    }
}

fn rmUnit(self: *GameState, event: events.UnitEvent) !void{
    //check if unit is found by id and remove
    const removed = self.unit_list.remove(event.unit_id);
    if (!removed) return BWAPIError.UnitRecordNotFound;
}
