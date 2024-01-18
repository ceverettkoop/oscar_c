const std = @import("std");
const bw = @import("bwenums.zig");
const bwapi = @import("bwapi_module.zig");
const dir = @import("directive.zig");
const GameState = @import("GameState.zig")

//if cur_builder succeeded, should delete itself
//if cur_builder no longer working we reassign it
const BuildTracker = struct{
    build_id: u32,
    cur_builder: c_int, //-1 for none/awaiting reassignment
    type: bw.UnitType,
    location: dir.TargetLocation
};

//called exactly once per desired building
//it will return a buildtracker that is added to gamestate
//the tracker must be handled elsewhere to get the build done
pub fn init_build(unit_type: bw.UnitType, location: dir.TargetLocation, gs: *GameState,
    Broodwar: ?*bwapi.Game) BuildTracker{
    const static_id = struct{
        var id: u32 = 0;
    };
    var return_tracker: BuildTracker = .{ 
        .build_id = static_id.id,
        .cur_builder = -1, //defaults to invalid
        .type = unit_type,
        .location = location
    };
    static_id.id += 1;
    const builder_type = bw.WhatBuilds[@intFromEnum(unit_type)];
    //iterate through known unit records
    for (gs.unit_list) |*record| {
        if(record.type != builder_type){
            continue;
        }
        switch (record.role) {
            gs.UnitRole.SCOUT => continue,
            gs.UnitRole.ARMY => continue,
            gs.UnitRole.BUILDER => continue, //this has to be set/unset properly!
            else => _
        }
        //eligible builder here
        return_tracker.cur_builder = record.id;
        break;
    }
    //early exit on failure, build to be picked up later
    if (return_tracker.cur_builder == -1){
        return return_tracker;
    }
    //initial call to build
    build(return_tracker, Broodwar);
    return return_tracker;
}

//naive attempt to build without tracking, tracker just holds
//parameters for what we are trying to do
fn build(track: ReturnTracker, Broodwar: ?*bwapi.Game) void{
    const unit_ptr = bwapi.Game_getUnit(Broodwar, @enumFromInt(track.cur_builder));
    if (unit_ptr) |u_ptr_val|{
        const builder_type = bw.WhatBuilds[@intFromEnum(unit_type)];
        //if we are just upgrading, just see if it's possible per bwapi
        if(builder_type != bw.UnitType.Zerg_Drone){ 
            if(bwapi.Unit_canMorph_UnitType(u_ptr_val, track.type, true, true)){
                const target_type: bwapi.UnitType = .{.id = @intFromEnum(track.type)};
                bwapi.Unit_morph(u_ptr_val, target_type);
                //gamestate will check if we succeeded
                return;
            }else return; //building to building up but not possible 
        //branch below is need to be built by a drone at a legal location case
        }else{

        }
    }else{
        print("Error getting unit_ptr on call to macro.build\n");
        return;
    }
}