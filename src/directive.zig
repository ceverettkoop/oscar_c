const std = @import("std");
const bw = @import("bwenums.zig");
const bwapi = @import("bwapi_module.zig");

pub const MacroCommandType = enum { BUILD, TRAIN, SCOUT, EXPAND, FORM_ARMY };

pub const PrereqType = enum { UNIT_QTY, TIMESTAMP, AI_FLAG, SUPPLY };

pub const TargetLocation = enum { MAIN, NATURAL, NEXT_VALID_EXP, LAST_SUCCESSFUL_EXP, ENEMY_MAIN, NEAREST_ENEMY_BASE, ANYWHERE };

pub const Prerequisite = struct {
    prereq_type: PrereqType,
    pre_req_qty: u8, //qty of unit required, or seconds elapsed or flag from oscar
    prereq_value: c_int, //negative values for ai_flags
};

pub const Command = struct {
    type: MacroCommandType,
    target_type: bw.UnitType,
    target_qty: u8,
    target_loc: TargetLocation,
};

pub const Directive = struct { prereq: Prerequisite, command: Command };

//(UNIT_QTY/SUPPLY/TIMESTAMP/FLAG) X (UNIT_TYPE/TIME/FLAG_VAL) : (COMMAND) X (UNIT_TYPE) (LOCATION)
//EXAMPLE
//(X is ignored when prereq type is not UNIT_QTY)
//SUPPLY 12 X : BUILD 1 Zerg_Spawning_Pool MAIN
//UNIT_QTY 8 Zerg_Mutalisk : FORM_ARMY 8 Zerg_Mutalisk ANYWHERE
//string, u8, c_int : string, u8, string, string

pub const ParseError = error{
    InvalidPrereqType,
    InvalidCommandType,
    InvalidLocation,
    InvalidUnitType,
    InvalidFormat,
    InvalidNumber,
};

fn parsePrereqType(str: []const u8) ParseError!PrereqType {
    return std.meta.stringToEnum(PrereqType, str) orelse ParseError.InvalidPrereqType;
}

fn parseCommandType(str: []const u8) ParseError!MacroCommandType {
    return std.meta.stringToEnum(MacroCommandType, str) orelse ParseError.InvalidCommandType;
}

fn parseLocation(str: []const u8) ParseError!TargetLocation {
    return std.meta.stringToEnum(TargetLocation, str) orelse ParseError.InvalidLocation;
}

fn parseUnitType(str: []const u8) ParseError!bw.UnitType {
    return std.meta.stringToEnum(bw.UnitType, str) orelse ParseError.InvalidUnitType;
}

fn parseLine(line: []const u8) ParseError!Directive {
    // Skip empty lines and comments
    if (line.len == 0 or line[0] == '#') {
        return ParseError.InvalidFormat;
    }

    // Split by colon
    var colon_split = std.mem.splitScalar(u8, line, ':');
    const prereq_part = std.mem.trim(u8, colon_split.next() orelse return ParseError.InvalidFormat, " \t\r\n");
    const command_part = std.mem.trim(u8, colon_split.next() orelse return ParseError.InvalidFormat, " \t\r\n");

    // Parse prerequisite: PREREQ_TYPE QTY VALUE
    var prereq_tokens = std.mem.tokenizeAny(u8, prereq_part, " \t");
    const prereq_type_str = prereq_tokens.next() orelse return ParseError.InvalidFormat;
    const prereq_qty_str = prereq_tokens.next() orelse return ParseError.InvalidFormat;
    const prereq_value_str = prereq_tokens.next() orelse return ParseError.InvalidFormat;

    const prereq_type = try parsePrereqType(prereq_type_str);
    const prereq_qty = std.fmt.parseInt(u8, prereq_qty_str, 10) catch return ParseError.InvalidNumber;

    // Parse prereq_value based on prereq_type
    const prereq_value: c_int = switch (prereq_type) {
        .UNIT_QTY => blk: {
            const unit_type = try parseUnitType(prereq_value_str);
            break :blk @intFromEnum(unit_type);
        },
        .TIMESTAMP => std.fmt.parseInt(c_int, prereq_value_str, 10) catch return ParseError.InvalidNumber,
        .AI_FLAG => std.fmt.parseInt(c_int, prereq_value_str, 10) catch return ParseError.InvalidNumber,
        .SUPPLY => 0, // X is ignored for SUPPLY
    };

    // Parse command: COMMAND_TYPE QTY UNIT_TYPE LOCATION
    var command_tokens = std.mem.tokenizeAny(u8, command_part, " \t");
    const command_type_str = command_tokens.next() orelse return ParseError.InvalidFormat;
    const command_qty_str = command_tokens.next() orelse return ParseError.InvalidFormat;
    const command_unit_str = command_tokens.next() orelse return ParseError.InvalidFormat;
    const command_loc_str = command_tokens.next() orelse return ParseError.InvalidFormat;

    const command_type = try parseCommandType(command_type_str);
    const command_qty = std.fmt.parseInt(u8, command_qty_str, 10) catch return ParseError.InvalidNumber;
    const target_type = try parseUnitType(command_unit_str);
    const target_loc = try parseLocation(command_loc_str);

    return Directive{
        .prereq = Prerequisite{
            .prereq_type = prereq_type,
            .pre_req_qty = prereq_qty,
            .prereq_value = prereq_value,
        },
        .command = Command{
            .type = command_type,
            .target_type = target_type,
            .target_qty = command_qty,
            .target_loc = target_loc,
        },
    };
}

pub fn parseDirectiveFile(allocator: std.mem.Allocator, file_path: []const u8) ![]Directive {
    const file = try std.fs.cwd().openFile(file_path, .{});
    defer file.close();

    const content = try file.readToEndAlloc(allocator, 1024 * 1024); // Max 1MB
    defer allocator.free(content);

    var directives = std.array_list.Managed(Directive).init(allocator);
    defer directives.deinit();

    var lines = std.mem.splitScalar(u8, content, '\n');
    while (lines.next()) |line| {
        const trimmed = std.mem.trim(u8, line, " \t\r");
        if (trimmed.len == 0 or trimmed[0] == '#') continue;

        const dir = parseLine(trimmed) catch |err| {
            std.debug.print("Error parsing line: {s}\n", .{trimmed});
            return err;
        };
        try directives.append(dir);
    }

    return directives.toOwnedSlice();
}
