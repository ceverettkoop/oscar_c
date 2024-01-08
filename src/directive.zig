const std = @import("std");
const bw = @import("bwenums.zig");
const bwapi = @import("bwapi_module.zig");

const MacroCommandType = enum{
    BUILD,
    TRAIN,
    SCOUT,
    EXPAND,
    FORM_ARMY
};

const PrereqType = enum{
    UNIT_QTY,
    TIMESTAMP,
    AI_FLAG,
    SUPPLY
};

const TargetLocation = enum{
    MAIN,
    NATURAL,
    NEXT_VALID_EXP,
    LAST_SUCCESSFUL_EXP,
    ENEMY_MAIN,
    NEAREST_ENEMY_BASE,
    ANYWHERE
};

const Prerequisite = struct{
    prereq_type: PrereqType,
    pre_req_qty: u8,//qty of unit required, or seconds elapsed or flag from oscar
    prereq_value: c_int //negative values for ai_flags
};

const Command = struct{
    type: MacroCommandType,
    target_type: bw.UnitType,
    target_qty: u8, 
    target_loc: TargetLocation,
};

const Directive = struct{
    prereq: Prerequisite,
    command: Command
};