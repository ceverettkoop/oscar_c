//imports for human added code
const std = @import("std");
const oscar = @import("oscar.zig");
const GameState = @import("GameState.zig");
const win = std.os.windows;
const bw = @import("bwenums.zig");
var GPA = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = GPA.allocator();

//only global ideally
var game_state: ?*GameState = null;

pub export fn gameInit(arg_game: ?*BWAPI_Game) void {
    var game = arg_game;
    Broodwar = @as(?*Game, @ptrCast(game));
    BWAPIC_setGame(Broodwar);
}
pub export fn newAIModule() ?*BWAPI_AIModule {
    const module: [*c]OscarModule = allocator.create(OscarModule) catch 0;
    module.*.name = "oscar";
    module.*.vtable_ = &module_vtable;
    return @as(?*BWAPI_AIModule, @ptrCast(createAIModuleWrapper(@as([*c]AIModule, @ptrCast(@alignCast(module))))));
}

pub export fn onStart(arg_self: [*c]AIModule) void {
    //module stuff
    var self = arg_self;
    var module: [*c]OscarModule = @as([*c]OscarModule, @ptrCast(@alignCast(self)));
    Game_sendText(Broodwar, "Hello from zig!");
    Game_sendText(Broodwar, "My name is %s", module.*.name);
    //end module
    
    //allocate gamestate
    game_state = allocator.create(GameState) catch null; //hack bc interfaces w c
    const gs_ptr: *GameState = game_state.?;
    gs_ptr.*.init(allocator, Broodwar);

    //cry if not zerg
    if(gs_ptr.*.self_race != @intFromEnum(bw.Race.Zerg) ){
        Game_sendText(Broodwar, "I am not zerg so no clue :(");
    }

}

pub export fn onEnd(arg_module: [*c]AIModule, arg_isWinner: bool) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var isWinner = arg_isWinner;
    _ = @TypeOf(isWinner);
    Game_sendText(Broodwar, "Game ended");
    const gs_ptr: *GameState = game_state.?;
    gs_ptr.*.deinit();
}

pub export fn onFrame(arg_self: [*c]AIModule) void {
    var self = arg_self;
    _ = @TypeOf(self);
    //actual bot here, pass it the game pointer along with allocator
    oscar.onFrame(Broodwar, allocator);
}


//END HUMAN WRITTEN CODE

pub const __builtin_bswap16 = @import("std").zig.c_builtins.__builtin_bswap16;
pub const __builtin_bswap32 = @import("std").zig.c_builtins.__builtin_bswap32;
pub const __builtin_bswap64 = @import("std").zig.c_builtins.__builtin_bswap64;
pub const __builtin_signbit = @import("std").zig.c_builtins.__builtin_signbit;
pub const __builtin_signbitf = @import("std").zig.c_builtins.__builtin_signbitf;
pub const __builtin_popcount = @import("std").zig.c_builtins.__builtin_popcount;
pub const __builtin_ctz = @import("std").zig.c_builtins.__builtin_ctz;
pub const __builtin_clz = @import("std").zig.c_builtins.__builtin_clz;
pub const __builtin_sqrt = @import("std").zig.c_builtins.__builtin_sqrt;
pub const __builtin_sqrtf = @import("std").zig.c_builtins.__builtin_sqrtf;
pub const __builtin_sin = @import("std").zig.c_builtins.__builtin_sin;
pub const __builtin_sinf = @import("std").zig.c_builtins.__builtin_sinf;
pub const __builtin_cos = @import("std").zig.c_builtins.__builtin_cos;
pub const __builtin_cosf = @import("std").zig.c_builtins.__builtin_cosf;
pub const __builtin_exp = @import("std").zig.c_builtins.__builtin_exp;
pub const __builtin_expf = @import("std").zig.c_builtins.__builtin_expf;
pub const __builtin_exp2 = @import("std").zig.c_builtins.__builtin_exp2;
pub const __builtin_exp2f = @import("std").zig.c_builtins.__builtin_exp2f;
pub const __builtin_log = @import("std").zig.c_builtins.__builtin_log;
pub const __builtin_logf = @import("std").zig.c_builtins.__builtin_logf;
pub const __builtin_log2 = @import("std").zig.c_builtins.__builtin_log2;
pub const __builtin_log2f = @import("std").zig.c_builtins.__builtin_log2f;
pub const __builtin_log10 = @import("std").zig.c_builtins.__builtin_log10;
pub const __builtin_log10f = @import("std").zig.c_builtins.__builtin_log10f;
pub const __builtin_abs = @import("std").zig.c_builtins.__builtin_abs;
pub const __builtin_fabs = @import("std").zig.c_builtins.__builtin_fabs;
pub const __builtin_fabsf = @import("std").zig.c_builtins.__builtin_fabsf;
pub const __builtin_floor = @import("std").zig.c_builtins.__builtin_floor;
pub const __builtin_floorf = @import("std").zig.c_builtins.__builtin_floorf;
pub const __builtin_ceil = @import("std").zig.c_builtins.__builtin_ceil;
pub const __builtin_ceilf = @import("std").zig.c_builtins.__builtin_ceilf;
pub const __builtin_trunc = @import("std").zig.c_builtins.__builtin_trunc;
pub const __builtin_truncf = @import("std").zig.c_builtins.__builtin_truncf;
pub const __builtin_round = @import("std").zig.c_builtins.__builtin_round;
pub const __builtin_roundf = @import("std").zig.c_builtins.__builtin_roundf;
pub const __builtin_strlen = @import("std").zig.c_builtins.__builtin_strlen;
pub const __builtin_strcmp = @import("std").zig.c_builtins.__builtin_strcmp;
pub const __builtin_object_size = @import("std").zig.c_builtins.__builtin_object_size;
pub const __builtin___memset_chk = @import("std").zig.c_builtins.__builtin___memset_chk;
pub const __builtin_memset = @import("std").zig.c_builtins.__builtin_memset;
pub const __builtin___memcpy_chk = @import("std").zig.c_builtins.__builtin___memcpy_chk;
pub const __builtin_memcpy = @import("std").zig.c_builtins.__builtin_memcpy;
pub const __builtin_expect = @import("std").zig.c_builtins.__builtin_expect;
pub const __builtin_nanf = @import("std").zig.c_builtins.__builtin_nanf;
pub const __builtin_huge_valf = @import("std").zig.c_builtins.__builtin_huge_valf;
pub const __builtin_inff = @import("std").zig.c_builtins.__builtin_inff;
pub const __builtin_isnan = @import("std").zig.c_builtins.__builtin_isnan;
pub const __builtin_isinf = @import("std").zig.c_builtins.__builtin_isinf;
pub const __builtin_isinf_sign = @import("std").zig.c_builtins.__builtin_isinf_sign;
pub const __has_builtin = @import("std").zig.c_builtins.__has_builtin;
pub const __builtin_assume = @import("std").zig.c_builtins.__builtin_assume;
pub const __builtin_unreachable = @import("std").zig.c_builtins.__builtin_unreachable;
pub const __builtin_constant_p = @import("std").zig.c_builtins.__builtin_constant_p;
pub const __builtin_mul_overflow = @import("std").zig.c_builtins.__builtin_mul_overflow;
pub const struct_Unit_ = opaque {};
pub const Unit = struct_Unit_;
pub const struct_Player_ = opaque {};
pub const Player = struct_Player_;
pub const struct_Region_ = opaque {};
pub const Region = struct_Region_;
pub const struct_Force_ = opaque {};
pub const Force = struct_Force_;
pub const struct_Bullet_ = opaque {};
pub const Bullet = struct_Bullet_;
pub const struct_Game_ = opaque {};
pub const Game = struct_Game_;
pub const struct_Client_ = opaque {};
pub const Client = struct_Client_;
pub const struct_Race = extern struct {
    id: c_int,
};
pub const Race = struct_Race;
pub const struct_Order = extern struct {
    id: c_int,
};
pub const Order = struct_Order;
pub const struct_Color = extern struct {
    color: c_int,
};
pub const Color = struct_Color;
pub const struct_TextSize = extern struct {
    size: c_int,
};
pub const TextSize = struct_TextSize;
pub const struct_CoordinateType = extern struct {
    id: c_int,
};
pub const CoordinateType = struct_CoordinateType;
pub const struct_MouseButton = extern struct {
    id: c_int,
};
pub const MouseButton = struct_MouseButton;
pub const struct_KeyButton = extern struct {
    id: c_int,
};
pub const KeyButton = struct_KeyButton;
pub const struct_Error = extern struct {
    id: c_int,
};
pub const Error = struct_Error;
pub const struct_UnitType = extern struct {
    id: c_int,
};
pub const UnitType = struct_UnitType;
pub const struct_PlayerType = extern struct {
    id: c_int,
};
pub const PlayerType = struct_PlayerType;
pub const struct_WeaponType = extern struct {
    id: c_int,
};
pub const WeaponType = struct_WeaponType;
pub const struct_TechType = extern struct {
    id: c_int,
};
pub const TechType = struct_TechType;
pub const struct_UpgradeType = extern struct {
    id: c_int,
};
pub const UpgradeType = struct_UpgradeType;
pub const struct_UnitCommandType = extern struct {
    id: c_int,
};
pub const UnitCommandType = struct_UnitCommandType;
pub const struct_BulletType = extern struct {
    id: c_int,
};
pub const BulletType = struct_BulletType;
pub const struct_GameType = extern struct {
    id: c_int,
};
pub const GameType = struct_GameType;
pub const struct_Position = extern struct {
    x: c_int,
    y: c_int,
};
pub const Position = struct_Position;
pub const struct_TilePosition = extern struct {
    x: c_int,
    y: c_int,
};
pub const TilePosition = struct_TilePosition;
pub const struct_WalkPosition = extern struct {
    x: c_int,
    y: c_int,
};
pub const WalkPosition = struct_WalkPosition;
pub const struct_UnitCommand = extern struct {
    unit: ?*Unit,
    type: UnitCommandType,
    target: ?*Unit,
    x: c_int,
    y: c_int,
    extra: c_int,
};
pub const UnitCommand = struct_UnitCommand;
pub const struct_BwString_ = opaque {};
pub const BwString = struct_BwString_;
pub const struct_EventType = extern struct {
    id: c_int,
};
pub const EventType = struct_EventType;
pub const struct_Event = extern struct {
    position: Position,
    text: ?*anyopaque,
    unit: ?*Unit,
    player: ?*Player,
    type: EventType,
    winner: bool,
};
pub const Event = struct_Event;
pub const struct_Iterator_ = opaque {};
pub const Iterator = struct_Iterator_;
pub const struct_UnitIterator_ = opaque {};
pub const UnitIterator = struct_UnitIterator_;
pub const struct_PlayerIterator_ = opaque {};
pub const PlayerIterator = struct_PlayerIterator_;
pub const struct_ForceIterator_ = opaque {};
pub const ForceIterator = struct_ForceIterator_;
pub const struct_BulletIterator_ = opaque {};
pub const BulletIterator = struct_BulletIterator_;
pub const struct_RegionIterator_ = opaque {};
pub const RegionIterator = struct_RegionIterator_;
pub const struct_PositionIterator_ = opaque {};
pub const PositionIterator = struct_PositionIterator_;
pub const struct_TilePositionIterator_ = opaque {};
pub const TilePositionIterator = struct_TilePositionIterator_;
pub const struct_EventIterator_ = opaque {};
pub const EventIterator = struct_EventIterator_;
pub const struct_UnitTypeIterator_ = opaque {};
pub const UnitTypeIterator = struct_UnitTypeIterator_;
pub const UnaryUnitFilter = ?*const fn (?*Unit) callconv(.C) bool;
pub const BestUnitFilter = ?*const fn (?*Unit, ?*Unit) callconv(.C) ?*Unit;
pub const AIModule_vtable = struct_AIModule_vtable;
pub const struct_AIModule = extern struct {
    vtable: [*c]const AIModule_vtable,
};
pub const AIModule = struct_AIModule;
pub const struct_AIModule_vtable = extern struct {
    onStart: ?*const fn ([*c]AIModule) callconv(.C) void,
    onEnd: ?*const fn ([*c]AIModule, bool) callconv(.C) void,
    onFrame: ?*const fn ([*c]AIModule) callconv(.C) void,
    onSendText: ?*const fn ([*c]AIModule, [*c]const u8) callconv(.C) void,
    onReceiveText: ?*const fn ([*c]AIModule, ?*Player, [*c]const u8) callconv(.C) void,
    onPlayerLeft: ?*const fn ([*c]AIModule, ?*Player) callconv(.C) void,
    onNukeDetect: ?*const fn ([*c]AIModule, Position) callconv(.C) void,
    onUnitDiscover: ?*const fn ([*c]AIModule, ?*Unit) callconv(.C) void,
    onUnitEvade: ?*const fn ([*c]AIModule, ?*Unit) callconv(.C) void,
    onUnitShow: ?*const fn ([*c]AIModule, ?*Unit) callconv(.C) void,
    onUnitHide: ?*const fn ([*c]AIModule, ?*Unit) callconv(.C) void,
    onUnitCreate: ?*const fn ([*c]AIModule, ?*Unit) callconv(.C) void,
    onUnitDestroy: ?*const fn ([*c]AIModule, ?*Unit) callconv(.C) void,
    onUnitMorph: ?*const fn ([*c]AIModule, ?*Unit) callconv(.C) void,
    onUnitRenegade: ?*const fn ([*c]AIModule, ?*Unit) callconv(.C) void,
    onSaveGame: ?*const fn ([*c]AIModule, [*c]const u8) callconv(.C) void,
    onUnitComplete: ?*const fn ([*c]AIModule, ?*Unit) callconv(.C) void,
};
pub extern fn createAIModuleWrapper(module: [*c]AIModule) ?*anyopaque;
pub extern fn destroyAIModuleWrapper(module: ?*anyopaque) void;
pub extern fn Bullet_getID(self: ?*Bullet) c_int;
pub extern fn Bullet_exists(self: ?*Bullet) bool;
pub extern fn Bullet_getPlayer(self: ?*Bullet) ?*Player;
pub extern fn Bullet_getType(self: ?*Bullet) BulletType;
pub extern fn Bullet_getSource(self: ?*Bullet) ?*Unit;
pub extern fn Bullet_getPosition(self: ?*Bullet) Position;
pub extern fn Bullet_getAngle(self: ?*Bullet) f64;
pub extern fn Bullet_getVelocityX(self: ?*Bullet) f64;
pub extern fn Bullet_getVelocityY(self: ?*Bullet) f64;
pub extern fn Bullet_getTarget(self: ?*Bullet) ?*Unit;
pub extern fn Bullet_getTargetPosition(self: ?*Bullet) Position;
pub extern fn Bullet_getRemoveTimer(self: ?*Bullet) c_int;
pub extern fn Bullet_isVisible(self: ?*Bullet, player: ?*Player) bool;
pub extern fn Bullet_registerEvent(self: ?*Bullet, action: ?*const fn (?*Bullet) callconv(.C) void, condition: ?*const fn (?*Bullet) callconv(.C) bool, timesToRun: c_int, framesToCheck: c_int) void;
pub extern fn Force_getID(self: ?*Force) c_int;
pub extern fn Force_getName(self: ?*Force) ?*BwString;
pub extern fn Force_getPlayers(self: ?*Force) ?*PlayerIterator;
pub const __builtin_va_list = [*c]u8;
pub const __gnuc_va_list = __builtin_va_list;
pub const va_list = __builtin_va_list;
pub extern fn BWAPIC_setGame(game: ?*Game) void;
pub extern fn BWAPIC_getGame(...) ?*Game;
pub extern fn Game_getForces(self: ?*Game) ?*ForceIterator;
pub extern fn Game_getPlayers(self: ?*Game) ?*PlayerIterator;
pub extern fn Game_getAllUnits(self: ?*Game) ?*UnitIterator;
pub extern fn Game_getMinerals(self: ?*Game) ?*UnitIterator;
pub extern fn Game_getGeysers(self: ?*Game) ?*UnitIterator;
pub extern fn Game_getNeutralUnits(self: ?*Game) ?*UnitIterator;
pub extern fn Game_getStaticMinerals(self: ?*Game) ?*UnitIterator;
pub extern fn Game_getStaticGeysers(self: ?*Game) ?*UnitIterator;
pub extern fn Game_getStaticNeutralUnits(self: ?*Game) ?*UnitIterator;
pub extern fn Game_getBullets(self: ?*Game) ?*BulletIterator;
pub extern fn Game_getNukeDots(self: ?*Game) ?*PositionIterator;
pub extern fn Game_getEvents(self: ?*Game) ?*EventIterator;
pub extern fn Game_getForce(self: ?*Game, forceID: c_int) ?*Force;
pub extern fn Game_getPlayer(self: ?*Game, playerID: c_int) ?*Player;
pub extern fn Game_getUnit(self: ?*Game, unitID: c_int) ?*Unit;
pub extern fn Game_indexToUnit(self: ?*Game, unitIndex: c_int) ?*Unit;
pub extern fn Game_getRegion(self: ?*Game, regionID: c_int) ?*Region;
pub extern fn Game_getGameType(self: ?*Game) GameType;
pub extern fn Game_getLatency(self: ?*Game) c_int;
pub extern fn Game_getFrameCount(self: ?*Game) c_int;
pub extern fn Game_getReplayFrameCount(self: ?*Game) c_int;
pub extern fn Game_getFPS(self: ?*Game) c_int;
pub extern fn Game_getAverageFPS(self: ?*Game) f64;
pub extern fn Game_getMousePosition(self: ?*Game) Position;
pub extern fn Game_getMouseState(self: ?*Game, button: MouseButton) bool;
pub extern fn Game_getKeyState(self: ?*Game, key: KeyButton) bool;
pub extern fn Game_getScreenPosition(self: ?*Game) Position;
pub extern fn Game_setScreenPosition(self: ?*Game, p: Position) void;
pub extern fn Game_pingMinimap(self: ?*Game, p: Position) void;
pub extern fn Game_isFlagEnabled(self: ?*Game, flag: c_int) bool;
pub extern fn Game_enableFlag(self: ?*Game, flag: c_int) void;
pub extern fn Game_getUnitsOnTile(self: ?*Game, tile: TilePosition, pred: UnaryUnitFilter) ?*UnitIterator;
pub extern fn Game_getUnitsInRectangle(self: ?*Game, topLeft: Position, bottomRight: Position, pred: UnaryUnitFilter) ?*UnitIterator;
pub extern fn Game_getUnitsInRadius(self: ?*Game, center: Position, radius: c_int, pred: UnaryUnitFilter) ?*UnitIterator;
pub extern fn Game_getClosestUnit(self: ?*Game, center: Position, pred: UnaryUnitFilter, radius: c_int) ?*Unit;
pub extern fn Game_getClosestUnitInRectangle(self: ?*Game, center: Position, pred: UnaryUnitFilter, left: c_int, top: c_int, right: c_int, bottom: c_int) ?*Unit;
pub extern fn Game_getBestUnit(self: ?*Game, best: BestUnitFilter, pred: UnaryUnitFilter, center: Position, radius: c_int) ?*Unit;
pub extern fn Game_getLastError(self: ?*Game) Error;
pub extern fn Game_setLastError(self: ?*Game, e: Error) bool;
pub extern fn Game_mapWidth(self: ?*Game) c_int;
pub extern fn Game_mapHeight(self: ?*Game) c_int;
pub extern fn Game_mapFileName(self: ?*Game) ?*BwString;
pub extern fn Game_mapPathName(self: ?*Game) ?*BwString;
pub extern fn Game_mapName(self: ?*Game) ?*BwString;
pub extern fn Game_mapHash(self: ?*Game) ?*BwString;
pub extern fn Game_isWalkable(self: ?*Game, position: WalkPosition) bool;
pub extern fn Game_getGroundHeight(self: ?*Game, position: TilePosition) c_int;
pub extern fn Game_isBuildable(self: ?*Game, position: TilePosition, includeBuildings: bool) bool;
pub extern fn Game_isVisible(self: ?*Game, position: TilePosition) bool;
pub extern fn Game_isExplored(self: ?*Game, position: TilePosition) bool;
pub extern fn Game_hasCreep(self: ?*Game, position: TilePosition) bool;
pub extern fn Game_hasPowerPrecise(self: ?*Game, position: Position, unitType: UnitType) bool;
pub extern fn Game_hasPower(self: ?*Game, position: TilePosition, unitType: UnitType) bool;
pub extern fn Game_hasPowerWH(self: ?*Game, position: TilePosition, tileWidth: c_int, tileHeight: c_int, unitType: UnitType) bool;
pub extern fn Game_canBuildHere(self: ?*Game, position: TilePosition, @"type": UnitType, builder: ?*Unit, checkExplored: bool) bool;
pub extern fn Game_canMake(self: ?*Game, @"type": UnitType, builder: ?*Unit) bool;
pub extern fn Game_canResearch(self: ?*Game, @"type": TechType, unit: ?*Unit, checkCanIssueCommandType: bool) bool;
pub extern fn Game_canUpgrade(self: ?*Game, @"type": UpgradeType, unit: ?*Unit, checkCanIssueCommandType: bool) bool;
pub extern fn Game_getStartLocations(self: ?*Game) ?*TilePositionIterator;
pub extern fn Game_printf(self: ?*Game, format: [*c]const u8, ...) void;
pub extern fn Game_vPrintf(self: ?*Game, format: [*c]const u8, args: va_list) void;
pub extern fn Game_sendText(self: ?*Game, format: [*c]const u8, ...) void;
pub extern fn Game_vSendText(self: ?*Game, format: [*c]const u8, args: va_list) void;
pub extern fn Game_sendTextEx(self: ?*Game, toAllies: bool, format: [*c]const u8, ...) void;
pub extern fn Game_vSendTextEx(self: ?*Game, toAllies: bool, format: [*c]const u8, args: va_list) void;
pub extern fn Game_isInGame(self: ?*Game) bool;
pub extern fn Game_isMultiplayer(self: ?*Game) bool;
pub extern fn Game_isBattleNet(self: ?*Game) bool;
pub extern fn Game_isPaused(self: ?*Game) bool;
pub extern fn Game_isReplay(self: ?*Game) bool;
pub extern fn Game_pauseGame(self: ?*Game) void;
pub extern fn Game_resumeGame(self: ?*Game) void;
pub extern fn Game_leaveGame(self: ?*Game) void;
pub extern fn Game_restartGame(self: ?*Game) void;
pub extern fn Game_setLocalSpeed(self: ?*Game, speed: c_int) void;
pub extern fn Game_issueCommand(self: ?*Game, units: ?*UnitIterator, command: UnitCommand) bool;
pub extern fn Game_getSelectedUnits(self: ?*Game) ?*UnitIterator;
pub extern fn Game_self(self: ?*Game) ?*Player;
pub extern fn Game_enemy(self: ?*Game) ?*Player;
pub extern fn Game_neutral(self: ?*Game) ?*Player;
pub extern fn Game_allies(self: ?*Game) ?*PlayerIterator;
pub extern fn Game_enemies(self: ?*Game) ?*PlayerIterator;
pub extern fn Game_observers(self: ?*Game) ?*PlayerIterator;
pub extern fn Game_setTextSize(self: ?*Game, size: TextSize) void;
pub extern fn Game_vDrawText(self: ?*Game, ctype: CoordinateType, x: c_int, y: c_int, format: [*c]const u8, args: va_list) void;
pub extern fn Game_drawText(self: ?*Game, ctype: CoordinateType, x: c_int, y: c_int, format: [*c]const u8, ...) void;
pub extern fn Game_drawTextMap(self: ?*Game, p: Position, format: [*c]const u8, ...) void;
pub extern fn Game_drawTextMouse(self: ?*Game, p: Position, format: [*c]const u8, ...) void;
pub extern fn Game_drawTextScreen(self: ?*Game, p: Position, format: [*c]const u8, ...) void;
pub extern fn Game_drawBox(self: ?*Game, ctype: CoordinateType, left: c_int, top: c_int, right: c_int, bottom: c_int, color: Color, isSolid: bool) void;
pub extern fn Game_drawBoxMap(self: ?*Game, leftTop: Position, rightBottom: Position, color: Color, isSolid: bool) void;
pub extern fn Game_drawBoxMouse(self: ?*Game, leftTop: Position, rightBottom: Position, color: Color, isSolid: bool) void;
pub extern fn Game_drawBoxScreen(self: ?*Game, leftTop: Position, rightBottom: Position, color: Color, isSolid: bool) void;
pub extern fn Game_drawTriangle(self: ?*Game, ctype: CoordinateType, ax: c_int, ay: c_int, bx: c_int, by: c_int, cx: c_int, cy: c_int, color: Color, isSolid: bool) void;
pub extern fn Game_drawTriangleMap(self: ?*Game, a: Position, b: Position, c: Position, color: Color, isSolid: bool) void;
pub extern fn Game_drawTriangleMouse(self: ?*Game, a: Position, b: Position, c: Position, color: Color, isSolid: bool) void;
pub extern fn Game_drawTriangleScreen(self: ?*Game, a: Position, b: Position, c: Position, color: Color, isSolid: bool) void;
pub extern fn Game_drawCircle(self: ?*Game, ctype: CoordinateType, x: c_int, y: c_int, radius: c_int, color: Color, isSolid: bool) void;
pub extern fn Game_drawCircleMap(self: ?*Game, p: Position, radius: c_int, color: Color, isSolid: bool) void;
pub extern fn Game_drawCircleMouse(self: ?*Game, p: Position, radius: c_int, color: Color, isSolid: bool) void;
pub extern fn Game_drawCircleScreen(self: ?*Game, p: Position, radius: c_int, color: Color, isSolid: bool) void;
pub extern fn Game_drawEllipse(self: ?*Game, ctype: CoordinateType, x: c_int, y: c_int, xrad: c_int, yrad: c_int, color: Color, isSolid: bool) void;
pub extern fn Game_drawEllipseMap(self: ?*Game, p: Position, xrad: c_int, yrad: c_int, color: Color, isSolid: bool) void;
pub extern fn Game_drawEllipseMouse(self: ?*Game, p: Position, xrad: c_int, yrad: c_int, color: Color, isSolid: bool) void;
pub extern fn Game_drawEllipseScreen(self: ?*Game, p: Position, xrad: c_int, yrad: c_int, color: Color, isSolid: bool) void;
pub extern fn Game_drawDot(self: ?*Game, ctype: CoordinateType, x: c_int, y: c_int, color: Color) void;
pub extern fn Game_drawDotMap(self: ?*Game, p: Position, color: Color) void;
pub extern fn Game_drawDotMouse(self: ?*Game, p: Position, color: Color) void;
pub extern fn Game_drawDotScreen(self: ?*Game, p: Position, color: Color) void;
pub extern fn Game_drawLine(self: ?*Game, ctype: CoordinateType, x1: c_int, y1: c_int, x2: c_int, y2: c_int, color: Color) void;
pub extern fn Game_drawLineMap(self: ?*Game, a: Position, b: Position, color: Color) void;
pub extern fn Game_drawLineMouse(self: ?*Game, a: Position, b: Position, color: Color) void;
pub extern fn Game_drawLineScreen(self: ?*Game, a: Position, b: Position, color: Color) void;
pub extern fn Game_getLatencyFrames(self: ?*Game) c_int;
pub extern fn Game_getLatencyTime(self: ?*Game) c_int;
pub extern fn Game_getRemainingLatencyFrames(self: ?*Game) c_int;
pub extern fn Game_getRemainingLatencyTime(self: ?*Game) c_int;
pub extern fn Game_getRevision(self: ?*Game) c_int;
pub extern fn Game_getClientVersion(self: ?*Game) c_int;
pub extern fn Game_isDebug(self: ?*Game) bool;
pub extern fn Game_isLatComEnabled(self: ?*Game) bool;
pub extern fn Game_setLatCom(self: ?*Game, isEnabled: bool) void;
pub extern fn Game_isGUIEnabled(self: ?*Game) bool;
pub extern fn Game_setGUI(self: ?*Game, enabled: bool) void;
pub extern fn Game_getInstanceNumber(self: ?*Game) c_int;
pub extern fn Game_getAPM(self: ?*Game, includeSelects: bool) c_int;
pub extern fn Game_setMap(self: ?*Game, mapFileName: [*c]const u8) bool;
pub extern fn Game_setFrameSkip(self: ?*Game, frameSkip: c_int) void;
pub extern fn Game_hasPath(self: ?*Game, source: Position, destination: Position) bool;
pub extern fn Game_setAlliance(self: ?*Game, player: ?*Player, allied: bool, alliedVictory: bool) bool;
pub extern fn Game_setVision(self: ?*Game, player: ?*Player, enabled: bool) bool;
pub extern fn Game_elapsedTime(self: ?*Game) c_int;
pub extern fn Game_setCommandOptimizationLevel(self: ?*Game, level: c_int) void;
pub extern fn Game_countdownTimer(self: ?*Game) c_int;
pub extern fn Game_getAllRegions(self: ?*Game) ?*RegionIterator;
pub extern fn Game_getRegionAt(self: ?*Game, position: Position) ?*Region;
pub extern fn Game_getLastEventTime(self: ?*Game) c_int;
pub extern fn Game_setRevealAll(self: ?*Game, reveal: bool) bool;
pub extern fn Game_getBuildLocation(self: ?*Game, @"type": UnitType, desiredPosition: TilePosition, maxRange: c_int, creep: bool) TilePosition;
pub extern fn Game_getDamageFrom(self: ?*Game, fromType: UnitType, toType: UnitType, fromPlayer: ?*Player, toPlayer: ?*Player) c_int;
pub extern fn Game_getDamageTo(self: ?*Game, toType: UnitType, fromType: UnitType, toPlayer: ?*Player, fromPlayer: ?*Player) c_int;
pub extern fn Game_getRandomSeed(self: ?*Game) c_uint;
pub extern fn Game_registerEvent(self: ?*Game, action: ?*const fn (?*Game) callconv(.C) void, condition: ?*const fn (?*Game) callconv(.C) bool, timesToRun: c_int, framesToCheck: c_int) void;
pub extern fn Iterator_valid(self: ?*const Iterator) bool;
pub extern fn Iterator_get(self: ?*const Iterator) ?*anyopaque;
pub extern fn Iterator_next(self: ?*Iterator) void;
pub extern fn Iterator_release(self: ?*Iterator) void;
pub extern fn Unit_getID(self: ?*Unit) c_int;
pub extern fn Unit_exists(self: ?*Unit) bool;
pub extern fn Unit_getReplayID(self: ?*Unit) c_int;
pub extern fn Unit_getPlayer(self: ?*Unit) ?*Player;
pub extern fn Unit_getType(self: ?*Unit) UnitType;
pub extern fn Unit_getPosition(self: ?*Unit) Position;
pub extern fn Unit_getTilePosition(self: ?*Unit) TilePosition;
pub extern fn Unit_getAngle(self: ?*Unit) f64;
pub extern fn Unit_getVelocityX(self: ?*Unit) f64;
pub extern fn Unit_getVelocityY(self: ?*Unit) f64;
pub extern fn Unit_getRegion(self: ?*Unit) ?*Region;
pub extern fn Unit_getLeft(self: ?*Unit) c_int;
pub extern fn Unit_getTop(self: ?*Unit) c_int;
pub extern fn Unit_getRight(self: ?*Unit) c_int;
pub extern fn Unit_getBottom(self: ?*Unit) c_int;
pub extern fn Unit_getHitPoints(self: ?*Unit) c_int;
pub extern fn Unit_getShields(self: ?*Unit) c_int;
pub extern fn Unit_getEnergy(self: ?*Unit) c_int;
pub extern fn Unit_getResources(self: ?*Unit) c_int;
pub extern fn Unit_getResourceGroup(self: ?*Unit) c_int;
pub extern fn Unit_getDistance_Position(self: ?*Unit, target: Position) c_int;
pub extern fn Unit_getDistance_Unit(self: ?*Unit, target: ?*Unit) c_int;
pub extern fn Unit_hasPath_Position(self: ?*Unit, target: Position) bool;
pub extern fn Unit_hasPath_Unit(self: ?*Unit, target: ?*Unit) bool;
pub extern fn Unit_getLastCommandFrame(self: ?*Unit) c_int;
pub extern fn Unit_getLastCommand(self: ?*Unit) UnitCommand;
pub extern fn Unit_getLastAttackingPlayer(self: ?*Unit) ?*Player;
pub extern fn Unit_getInitialType(self: ?*Unit) UnitType;
pub extern fn Unit_getInitialPosition(self: ?*Unit) Position;
pub extern fn Unit_getInitialTilePosition(self: ?*Unit) TilePosition;
pub extern fn Unit_getInitialHitPoints(self: ?*Unit) c_int;
pub extern fn Unit_getInitialResources(self: ?*Unit) c_int;
pub extern fn Unit_getKillCount(self: ?*Unit) c_int;
pub extern fn Unit_getAcidSporeCount(self: ?*Unit) c_int;
pub extern fn Unit_getInterceptorCount(self: ?*Unit) c_int;
pub extern fn Unit_getScarabCount(self: ?*Unit) c_int;
pub extern fn Unit_getSpiderMineCount(self: ?*Unit) c_int;
pub extern fn Unit_getGroundWeaponCooldown(self: ?*Unit) c_int;
pub extern fn Unit_getAirWeaponCooldown(self: ?*Unit) c_int;
pub extern fn Unit_getSpellCooldown(self: ?*Unit) c_int;
pub extern fn Unit_getDefenseMatrixPoints(self: ?*Unit) c_int;
pub extern fn Unit_getDefenseMatrixTimer(self: ?*Unit) c_int;
pub extern fn Unit_getEnsnareTimer(self: ?*Unit) c_int;
pub extern fn Unit_getIrradiateTimer(self: ?*Unit) c_int;
pub extern fn Unit_getLockdownTimer(self: ?*Unit) c_int;
pub extern fn Unit_getMaelstromTimer(self: ?*Unit) c_int;
pub extern fn Unit_getOrderTimer(self: ?*Unit) c_int;
pub extern fn Unit_getPlagueTimer(self: ?*Unit) c_int;
pub extern fn Unit_getRemoveTimer(self: ?*Unit) c_int;
pub extern fn Unit_getStasisTimer(self: ?*Unit) c_int;
pub extern fn Unit_getStimTimer(self: ?*Unit) c_int;
pub extern fn Unit_getBuildType(self: ?*Unit) UnitType;
pub extern fn Unit_getTrainingQueue(self: ?*Unit) ?*UnitTypeIterator;
pub extern fn Unit_getTech(self: ?*Unit) TechType;
pub extern fn Unit_getUpgrade(self: ?*Unit) UpgradeType;
pub extern fn Unit_getRemainingBuildTime(self: ?*Unit) c_int;
pub extern fn Unit_getRemainingTrainTime(self: ?*Unit) c_int;
pub extern fn Unit_getRemainingResearchTime(self: ?*Unit) c_int;
pub extern fn Unit_getRemainingUpgradeTime(self: ?*Unit) c_int;
pub extern fn Unit_getBuildUnit(self: ?*Unit) ?*Unit;
pub extern fn Unit_getTarget(self: ?*Unit) ?*Unit;
pub extern fn Unit_getTargetPosition(self: ?*Unit) Position;
pub extern fn Unit_getOrder(self: ?*Unit) Order;
pub extern fn Unit_getSecondaryOrder(self: ?*Unit) Order;
pub extern fn Unit_getOrderTarget(self: ?*Unit) ?*Unit;
pub extern fn Unit_getOrderTargetPosition(self: ?*Unit) Position;
pub extern fn Unit_getRallyPosition(self: ?*Unit) Position;
pub extern fn Unit_getRallyUnit(self: ?*Unit) ?*Unit;
pub extern fn Unit_getAddon(self: ?*Unit) ?*Unit;
pub extern fn Unit_getNydusExit(self: ?*Unit) ?*Unit;
pub extern fn Unit_getPowerUp(self: ?*Unit) ?*Unit;
pub extern fn Unit_getTransport(self: ?*Unit) ?*Unit;
pub extern fn Unit_getLoadedUnits(self: ?*Unit) ?*UnitIterator;
pub extern fn Unit_getSpaceRemaining(self: ?*Unit) c_int;
pub extern fn Unit_getCarrier(self: ?*Unit) ?*Unit;
pub extern fn Unit_getInterceptors(self: ?*Unit) ?*UnitIterator;
pub extern fn Unit_getHatchery(self: ?*Unit) ?*Unit;
pub extern fn Unit_getLarva(self: ?*Unit) ?*UnitIterator;
pub extern fn Unit_getUnitsInRadius(self: ?*Unit, radius: c_int, pred: UnaryUnitFilter) ?*UnitIterator;
pub extern fn Unit_getUnitsInWeaponRange(self: ?*Unit, weapon: WeaponType, pred: UnaryUnitFilter) ?*UnitIterator;
pub extern fn Unit_getClosestUnit(self: ?*Unit, pred: UnaryUnitFilter, radius: c_int) ?*Unit;
pub extern fn Unit_hasNuke(self: ?*Unit) bool;
pub extern fn Unit_isAccelerating(self: ?*Unit) bool;
pub extern fn Unit_isAttacking(self: ?*Unit) bool;
pub extern fn Unit_isAttackFrame(self: ?*Unit) bool;
pub extern fn Unit_isBeingConstructed(self: ?*Unit) bool;
pub extern fn Unit_isBeingGathered(self: ?*Unit) bool;
pub extern fn Unit_isBeingHealed(self: ?*Unit) bool;
pub extern fn Unit_isBlind(self: ?*Unit) bool;
pub extern fn Unit_isBraking(self: ?*Unit) bool;
pub extern fn Unit_isBurrowed(self: ?*Unit) bool;
pub extern fn Unit_isCarryingGas(self: ?*Unit) bool;
pub extern fn Unit_isCarryingMinerals(self: ?*Unit) bool;
pub extern fn Unit_isCloaked(self: ?*Unit) bool;
pub extern fn Unit_isCompleted(self: ?*Unit) bool;
pub extern fn Unit_isConstructing(self: ?*Unit) bool;
pub extern fn Unit_isDefenseMatrixed(self: ?*Unit) bool;
pub extern fn Unit_isDetected(self: ?*Unit) bool;
pub extern fn Unit_isEnsnared(self: ?*Unit) bool;
pub extern fn Unit_isFlying(self: ?*Unit) bool;
pub extern fn Unit_isFollowing(self: ?*Unit) bool;
pub extern fn Unit_isGatheringGas(self: ?*Unit) bool;
pub extern fn Unit_isGatheringMinerals(self: ?*Unit) bool;
pub extern fn Unit_isHallucination(self: ?*Unit) bool;
pub extern fn Unit_isHoldingPosition(self: ?*Unit) bool;
pub extern fn Unit_isIdle(self: ?*Unit) bool;
pub extern fn Unit_isInterruptible(self: ?*Unit) bool;
pub extern fn Unit_isInvincible(self: ?*Unit) bool;
pub extern fn Unit_isInWeaponRange(self: ?*Unit, target: ?*Unit) bool;
pub extern fn Unit_isIrradiated(self: ?*Unit) bool;
pub extern fn Unit_isLifted(self: ?*Unit) bool;
pub extern fn Unit_isLoaded(self: ?*Unit) bool;
pub extern fn Unit_isLockedDown(self: ?*Unit) bool;
pub extern fn Unit_isMaelstrommed(self: ?*Unit) bool;
pub extern fn Unit_isMorphing(self: ?*Unit) bool;
pub extern fn Unit_isMoving(self: ?*Unit) bool;
pub extern fn Unit_isParasited(self: ?*Unit) bool;
pub extern fn Unit_isPatrolling(self: ?*Unit) bool;
pub extern fn Unit_isPlagued(self: ?*Unit) bool;
pub extern fn Unit_isRepairing(self: ?*Unit) bool;
pub extern fn Unit_isResearching(self: ?*Unit) bool;
pub extern fn Unit_isSelected(self: ?*Unit) bool;
pub extern fn Unit_isSieged(self: ?*Unit) bool;
pub extern fn Unit_isStartingAttack(self: ?*Unit) bool;
pub extern fn Unit_isStasised(self: ?*Unit) bool;
pub extern fn Unit_isStimmed(self: ?*Unit) bool;
pub extern fn Unit_isStuck(self: ?*Unit) bool;
pub extern fn Unit_isTraining(self: ?*Unit) bool;
pub extern fn Unit_isUnderAttack(self: ?*Unit) bool;
pub extern fn Unit_isUnderDarkSwarm(self: ?*Unit) bool;
pub extern fn Unit_isUnderDisruptionWeb(self: ?*Unit) bool;
pub extern fn Unit_isUnderStorm(self: ?*Unit) bool;
pub extern fn Unit_isPowered(self: ?*Unit) bool;
pub extern fn Unit_isUpgrading(self: ?*Unit) bool;
pub extern fn Unit_isVisible(self: ?*Unit, player: ?*Player) bool;
pub extern fn Unit_isTargetable(self: ?*Unit) bool;
pub extern fn Unit_issueCommand(self: ?*Unit, command: UnitCommand) bool;
pub extern fn Unit_attack_Position(self: ?*Unit, target: Position, shiftQueueCommand: bool) bool;
pub extern fn Unit_attack_Unit(self: ?*Unit, target: ?*Unit, shiftQueueCommand: bool) bool;
pub extern fn Unit_build(self: ?*Unit, @"type": UnitType, target: TilePosition) bool;
pub extern fn Unit_buildAddon(self: ?*Unit, @"type": UnitType) bool;
pub extern fn Unit_train(self: ?*Unit, @"type": UnitType) bool;
pub extern fn Unit_morph(self: ?*Unit, @"type": UnitType) bool;
pub extern fn Unit_research(self: ?*Unit, tech: TechType) bool;
pub extern fn Unit_upgrade(self: ?*Unit, upgrade: UpgradeType) bool;
pub extern fn Unit_setRallyPoint_Position(self: ?*Unit, target: Position) bool;
pub extern fn Unit_setRallyPoint_Target(self: ?*Unit, target: ?*Unit) bool;
pub extern fn Unit_move(self: ?*Unit, target: Position, shiftQueueCommand: bool) bool;
pub extern fn Unit_patrol(self: ?*Unit, target: Position, shiftQueueCommand: bool) bool;
pub extern fn Unit_holdPosition(self: ?*Unit, shiftQueueCommand: bool) bool;
pub extern fn Unit_stop(self: ?*Unit, shiftQueueCommand: bool) bool;
pub extern fn Unit_follow(self: ?*Unit, target: ?*Unit, shiftQueueCommand: bool) bool;
pub extern fn Unit_gather(self: ?*Unit, target: ?*Unit, shiftQueueCommand: bool) bool;
pub extern fn Unit_returnCargo(self: ?*Unit, shiftQueueCommand: bool) bool;
pub extern fn Unit_repair(self: ?*Unit, target: ?*Unit, shiftQueueCommand: bool) bool;
pub extern fn Unit_burrow(self: ?*Unit) bool;
pub extern fn Unit_unburrow(self: ?*Unit) bool;
pub extern fn Unit_cloak(self: ?*Unit) bool;
pub extern fn Unit_decloak(self: ?*Unit) bool;
pub extern fn Unit_siege(self: ?*Unit) bool;
pub extern fn Unit_unsiege(self: ?*Unit) bool;
pub extern fn Unit_lift(self: ?*Unit) bool;
pub extern fn Unit_land(self: ?*Unit, target: TilePosition) bool;
pub extern fn Unit_load(self: ?*Unit, target: ?*Unit, shiftQueueCommand: bool) bool;
pub extern fn Unit_unload(self: ?*Unit, target: ?*Unit) bool;
pub extern fn Unit_unloadAll(self: ?*Unit, shiftQueueCommand: bool) bool;
pub extern fn Unit_unloadAll_Position(self: ?*Unit, target: Position, shiftQueueCommand: bool) bool;
pub extern fn Unit_rightClick_Position(self: ?*Unit, target: Position, shiftQueueCommand: bool) bool;
pub extern fn Unit_rightClick_Unit(self: ?*Unit, target: ?*Unit, shiftQueueCommand: bool) bool;
pub extern fn Unit_haltConstruction(self: ?*Unit) bool;
pub extern fn Unit_cancelConstruction(self: ?*Unit) bool;
pub extern fn Unit_cancelAddon(self: ?*Unit) bool;
pub extern fn Unit_cancelTrain(self: ?*Unit, slot: c_int) bool;
pub extern fn Unit_cancelMorph(self: ?*Unit) bool;
pub extern fn Unit_cancelResearch(self: ?*Unit) bool;
pub extern fn Unit_cancelUpgrade(self: ?*Unit) bool;
pub extern fn Unit_useTech_Position(self: ?*Unit, tech: TechType, target: Position) bool;
pub extern fn Unit_useTech_Unit(self: ?*Unit, tech: TechType, target: ?*Unit) bool;
pub extern fn Unit_placeCOP(self: ?*Unit, target: TilePosition) bool;
pub extern fn Unit_canIssueCommand(self: ?*Unit, command: UnitCommand, checkCanUseTechPositionOnPositions: bool, checkCanUseTechUnitOnUnits: bool, checkCanBuildUnitType: bool, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canIssueCommandGrouped(self: ?*Unit, command: UnitCommand, checkCanUseTechPositionOnPositions: bool, checkCanUseTechUnitOnUnits: bool, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canCommand(self: ?*Unit) bool;
pub extern fn Unit_canCommandGrouped(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canIssueCommandType(self: ?*Unit, ct: UnitCommandType, checkCommandibility: bool) bool;
pub extern fn Unit_canIssueCommandTypeGrouped(self: ?*Unit, ct: UnitCommandType, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canTargetUnit(self: ?*Unit, targetUnit: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canAttack(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canAttack_Position(self: ?*Unit, target: Position, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canAttack_Unit(self: ?*Unit, target: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canAttackGrouped(self: ?*Unit, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canAttackGrouped_Position(self: ?*Unit, target: Position, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canAttackGrouped_Unit(self: ?*Unit, target: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canAttackMove(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canAttackMoveGrouped(self: ?*Unit, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canAttackUnit(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canAttackUnit_Unit(self: ?*Unit, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canAttackUnitGrouped(self: ?*Unit, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canAttackUnitGrouped_Unit(self: ?*Unit, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canBuild(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canBuild_UnitType(self: ?*Unit, uType: UnitType, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canBuild_UnitType_TilePosition(self: ?*Unit, uType: UnitType, tilePos: TilePosition, checkTargetUnitType: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canBuildAddon(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canBuildAddon_UnitType(self: ?*Unit, uType: UnitType, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canTrain(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canTrain_UnitType(self: ?*Unit, uType: UnitType, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canMorph(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canMorph_UnitType(self: ?*Unit, uType: UnitType, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canResearch(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canResearch_TechType(self: ?*Unit, @"type": TechType, checkCanIssueCommandType: bool) bool;
pub extern fn Unit_canUpgrade(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canUpgrade_UpgradeType(self: ?*Unit, @"type": UpgradeType, checkCanIssueCommandType: bool) bool;
pub extern fn Unit_canSetRallyPoint(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canSetRallyPoint_Position(self: ?*Unit, target: Position, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canSetRallyPoint_Unit(self: ?*Unit, target: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canSetRallyPosition(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canSetRallyUnit(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canSetRallyUnit_Unit(self: ?*Unit, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canMove(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canMoveGrouped(self: ?*Unit, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canPatrol(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canPatrolGrouped(self: ?*Unit, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canFollow(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canFollow_Unit(self: ?*Unit, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canGather(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canGather_Unit(self: ?*Unit, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canReturnCargo(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canHoldPosition(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canStop(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canRepair(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canRepair_Unit(self: ?*Unit, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canBurrow(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canUnburrow(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canCloak(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canDecloak(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canSiege(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canUnsiege(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canLift(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canLand(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canLand_TilePosition(self: ?*Unit, target: TilePosition, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canLoad(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canLoad_Unit(self: ?*Unit, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canUnloadWithOrWithoutTarget(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canUnloadAtPosition(self: ?*Unit, targDropPos: Position, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canUnload(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canUnload_Unit(self: ?*Unit, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkPosition: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canUnloadAll(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canUnloadAllPosition(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canUnloadAllPosition_Position(self: ?*Unit, targDropPos: Position, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClick(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClick_Position(self: ?*Unit, target: Position, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClick_Unit(self: ?*Unit, target: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClickGrouped(self: ?*Unit, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClickGrouped_Position(self: ?*Unit, target: Position, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClickGrouped_Unit(self: ?*Unit, target: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClickPosition(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClickPositionGrouped(self: ?*Unit, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClickUnit(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClickUnit_Unit(self: ?*Unit, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClickUnitGrouped(self: ?*Unit, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canRightClickUnitGrouped_Unit(self: ?*Unit, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkCanIssueCommandType: bool, checkCommandibilityGrouped: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canHaltConstruction(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canCancelConstruction(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canCancelAddon(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canCancelTrain(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canCancelTrainSlot(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canCancelTrainSlot_Check(self: ?*Unit, slot: c_int, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canCancelMorph(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canCancelResearch(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canCancelUpgrade(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canUseTechWithOrWithoutTarget(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canUseTechWithOrWithoutTarget_TechType(self: ?*Unit, tech: TechType, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canUseTech_Position(self: ?*Unit, tech: TechType, target: Position, checkCanTargetUnit: bool, checkTargetsType: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canUseTech_Unit(self: ?*Unit, tech: TechType, target: ?*Unit, checkCanTargetUnit: bool, checkTargetsType: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canUseTechWithoutTarget(self: ?*Unit, tech: TechType, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canUseTechUnit(self: ?*Unit, tech: TechType, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canUseTechUnit_Unit(self: ?*Unit, tech: TechType, targetUnit: ?*Unit, checkCanTargetUnit: bool, checkTargetsUnits: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canUseTechPosition(self: ?*Unit, tech: TechType, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canUseTechPosition_Position(self: ?*Unit, tech: TechType, target: Position, checkTargetsPositions: bool, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_canPlaceCOP(self: ?*Unit, checkCommandibility: bool) bool;
pub extern fn Unit_canPlaceCOP_TilePosition(self: ?*Unit, target: TilePosition, checkCanIssueCommandType: bool, checkCommandibility: bool) bool;
pub extern fn Unit_registerEvent(self: ?*Unit, action: ?*const fn (?*Unit) callconv(.C) void, condition: ?*const fn (?*Unit) callconv(.C) bool, timesToRun: c_int, framesToCheck: c_int) void;
pub extern fn Player_getID(self: ?*Player) c_int;
pub extern fn Player_getName(self: ?*Player) ?*BwString;
pub extern fn Player_getUnits(self: ?*Player) ?*UnitIterator;
pub extern fn Player_getRace(self: ?*Player) Race;
pub extern fn Player_getType(self: ?*Player) PlayerType;
pub extern fn Player_getForce(self: ?*Player) ?*Force;
pub extern fn Player_isAlly(self: ?*Player, player: ?*Player) bool;
pub extern fn Player_isEnemy(self: ?*Player, player: ?*Player) bool;
pub extern fn Player_isNeutral(self: ?*Player) bool;
pub extern fn Player_getStartLocation(self: ?*Player) TilePosition;
pub extern fn Player_isVictorious(self: ?*Player) bool;
pub extern fn Player_isDefeated(self: ?*Player) bool;
pub extern fn Player_leftGame(self: ?*Player) bool;
pub extern fn Player_minerals(self: ?*Player) c_int;
pub extern fn Player_gas(self: ?*Player) c_int;
pub extern fn Player_gatheredMinerals(self: ?*Player) c_int;
pub extern fn Player_gatheredGas(self: ?*Player) c_int;
pub extern fn Player_repairedMinerals(self: ?*Player) c_int;
pub extern fn Player_repairedGas(self: ?*Player) c_int;
pub extern fn Player_refundedMinerals(self: ?*Player) c_int;
pub extern fn Player_refundedGas(self: ?*Player) c_int;
pub extern fn Player_spentMinerals(self: ?*Player) c_int;
pub extern fn Player_spentGas(self: ?*Player) c_int;
pub extern fn Player_supplyTotal(self: ?*Player, race: Race) c_int;
pub extern fn Player_supplyUsed(self: ?*Player, race: Race) c_int;
pub extern fn Player_allUnitCount(self: ?*Player, unit: UnitType) c_int;
pub extern fn Player_visibleUnitCount(self: ?*Player, unit: UnitType) c_int;
pub extern fn Player_completedUnitCount(self: ?*Player, unit: UnitType) c_int;
pub extern fn Player_incompleteUnitCount(self: ?*Player, unit: UnitType) c_int;
pub extern fn Player_deadUnitCount(self: ?*Player, unit: UnitType) c_int;
pub extern fn Player_killedUnitCount(self: ?*Player, unit: UnitType) c_int;
pub extern fn Player_getUpgradeLevel(self: ?*Player, upgrade: UpgradeType) c_int;
pub extern fn Player_hasResearched(self: ?*Player, tech: TechType) bool;
pub extern fn Player_isResearching(self: ?*Player, tech: TechType) bool;
pub extern fn Player_isUpgrading(self: ?*Player, upgrade: UpgradeType) bool;
pub extern fn Player_getColor(self: ?*Player) Color;
pub extern fn Player_getTextColor(self: ?*Player) u8;
pub extern fn Player_maxEnergy(self: ?*Player, unit: UnitType) c_int;
pub extern fn Player_topSpeed(self: ?*Player, unit: UnitType) f64;
pub extern fn Player_weaponMaxRange(self: ?*Player, weapon: WeaponType) c_int;
pub extern fn Player_sightRange(self: ?*Player, unit: UnitType) c_int;
pub extern fn Player_weaponDamageCooldown(self: ?*Player, unit: UnitType) c_int;
pub extern fn Player_armor(self: ?*Player, unit: UnitType) c_int;
pub extern fn Player_damage(self: ?*Player, wpn: WeaponType) c_int;
pub extern fn Player_getUnitScore(self: ?*Player) c_int;
pub extern fn Player_getKillScore(self: ?*Player) c_int;
pub extern fn Player_getBuildingScore(self: ?*Player) c_int;
pub extern fn Player_getRazingScore(self: ?*Player) c_int;
pub extern fn Player_getCustomScore(self: ?*Player) c_int;
pub extern fn Player_isObserver(self: ?*Player) bool;
pub extern fn Player_getMaxUpgradeLevel(self: ?*Player, upgrade: UpgradeType) c_int;
pub extern fn Player_isResearchAvailable(self: ?*Player, tech: TechType) bool;
pub extern fn Player_isUnitAvailable(self: ?*Player, unit: UnitType) bool;
pub extern fn Player_hasUnitTypeRequirement(self: ?*Player, unit: UnitType, amount: c_int) bool;
pub extern fn Player_registerEvent(self: ?*Player, action: ?*const fn (?*Player) callconv(.C) void, condition: ?*const fn (?*Player) callconv(.C) bool, timesToRun: c_int, framesToCheck: c_int) void;
pub extern fn Region_getID(self: ?*Region) c_int;
pub extern fn Region_getRegionGroupID(self: ?*Region) c_int;
pub extern fn Region_getCenter(self: ?*Region) Position;
pub extern fn Region_isHigherGround(self: ?*Region) bool;
pub extern fn Region_getDefensePriority(self: ?*Region) c_int;
pub extern fn Region_isAccessible(self: ?*Region) bool;
pub extern fn Region_getNeighbors(self: ?*Region) ?*RegionIterator;
pub extern fn Region_getBoundsLeft(self: ?*Region) c_int;
pub extern fn Region_getBoundsTop(self: ?*Region) c_int;
pub extern fn Region_getBoundsRight(self: ?*Region) c_int;
pub extern fn Region_getBoundsBottom(self: ?*Region) c_int;
pub extern fn Region_getClosestAccessibleRegion(self: ?*Region) ?*Region;
pub extern fn Region_getClosestInaccessibleRegion(self: ?*Region) ?*Region;
pub extern fn Region_getDistance(self: ?*Region, other: ?*Region) c_int;
pub extern fn Region_getUnits(self: ?*Region, pred: UnaryUnitFilter) ?*UnitIterator;
pub extern fn Region_registerEvent(self: ?*Region, action: ?*const fn (?*Region) callconv(.C) void, condition: ?*const fn (?*Region) callconv(.C) bool, timesToRun: c_int, framesToCheck: c_int) void;
pub extern fn BwString_new(data: [*c]const u8, len: c_int) ?*BwString;
pub extern fn BwString_data(self: ?*const BwString) [*c]const u8;
pub extern fn BwString_len(self: ?*const BwString) c_int;
pub extern fn BwString_release(self: ?*BwString) void;
pub extern fn Event_getText(self: [*c]const Event) ?*BwString;
pub const struct_BWAPI_Game = opaque {};
pub const BWAPI_Game = struct_BWAPI_Game;
pub const struct_BWAPI_AIModule = opaque {};
pub const BWAPI_AIModule = struct_BWAPI_AIModule;
pub var Broodwar: ?*Game = @import("std").mem.zeroes(?*Game);
pub const struct_OscarModule_tag = extern struct {
    vtable_: [*c]const AIModule_vtable,
    name: [*c]const u8,
};
pub const OscarModule = struct_OscarModule_tag;

pub export fn onSendText(arg_module: [*c]AIModule, arg_text: [*c]const u8) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var text = arg_text;
    _ = @TypeOf(text);
}
pub export fn onReceiveText(arg_module: [*c]AIModule, arg_player: ?*Player, arg_text: [*c]const u8) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var player = arg_player;
    _ = @TypeOf(player);
    var text = arg_text;
    _ = @TypeOf(text);
}
pub export fn onPlayerLeft(arg_module: [*c]AIModule, arg_player: ?*Player) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var player = arg_player;
    _ = @TypeOf(player);
}
pub export fn onNukeDetect(arg_module: [*c]AIModule, arg_target: Position) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var target = arg_target;
    _ = @TypeOf(target);
}
pub export fn onUnitDiscover(arg_module: [*c]AIModule, arg_unit: ?*Unit) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var unit = arg_unit;
    _ = @TypeOf(unit);
}
pub export fn onUnitEvade(arg_module: [*c]AIModule, arg_unit: ?*Unit) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var unit = arg_unit;
    _ = @TypeOf(unit);
}
pub export fn onUnitShow(arg_module: [*c]AIModule, arg_unit: ?*Unit) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var unit = arg_unit;
    _ = @TypeOf(unit);
}
pub export fn onUnitHide(arg_module: [*c]AIModule, arg_unit: ?*Unit) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var unit = arg_unit;
    _ = @TypeOf(unit);
}
pub export fn onUnitCreate(arg_module: [*c]AIModule, arg_unit: ?*Unit) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var unit = arg_unit;
    _ = @TypeOf(unit);
}
pub export fn onUnitDestroy(arg_module: [*c]AIModule, arg_unit: ?*Unit) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var unit = arg_unit;
    _ = @TypeOf(unit);
}
pub export fn onUnitMorph(arg_module: [*c]AIModule, arg_unit: ?*Unit) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var unit = arg_unit;
    _ = @TypeOf(unit);
}
pub export fn onUnitRenegade(arg_module: [*c]AIModule, arg_unit: ?*Unit) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var unit = arg_unit;
    _ = @TypeOf(unit);
}
pub export fn onSaveGame(arg_module: [*c]AIModule, arg_gameName: [*c]const u8) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var gameName = arg_gameName;
    _ = @TypeOf(gameName);
}
pub export fn onUnitComplete(arg_module: [*c]AIModule, arg_unit: ?*Unit) void {
    var module = arg_module;
    _ = @TypeOf(module);
    var unit = arg_unit;
    _ = @TypeOf(unit);
}
pub var module_vtable: AIModule_vtable = AIModule_vtable{
    .onStart = &onStart,
    .onEnd = &onEnd,
    .onFrame = &onFrame,
    .onSendText = &onSendText,
    .onReceiveText = &onReceiveText,
    .onPlayerLeft = &onPlayerLeft,
    .onNukeDetect = &onNukeDetect,
    .onUnitDiscover = &onUnitDiscover,
    .onUnitEvade = &onUnitEvade,
    .onUnitShow = &onUnitShow,
    .onUnitHide = &onUnitHide,
    .onUnitCreate = &onUnitCreate,
    .onUnitDestroy = &onUnitDestroy,
    .onUnitMorph = &onUnitMorph,
    .onUnitRenegade = &onUnitRenegade,
    .onSaveGame = &onSaveGame,
    .onUnitComplete = &onUnitComplete,
};

pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `LL`"); // (no file):75:9
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `ULL`"); // (no file):81:9
pub const __FLT16_DENORM_MIN__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):104:9
pub const __FLT16_EPSILON__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):108:9
pub const __FLT16_MAX__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):114:9
pub const __FLT16_MIN__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):117:9
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `LL`"); // (no file):179:9
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`"); // (no file):201:9
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `ULL`"); // (no file):209:9
pub const __USER_LABEL_PREFIX__ = @compileError("unable to translate macro: undefined identifier `_`"); // (no file):300:9
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // (no file):322:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // (no file):323:9
pub const va_start = @compileError("unable to translate macro: undefined identifier `__builtin_va_start`"); // /opt/homebrew/Cellar/zig/0.11.0/lib/zig/include/stdarg.h:33:9
pub const va_end = @compileError("unable to translate macro: undefined identifier `__builtin_va_end`"); // /opt/homebrew/Cellar/zig/0.11.0/lib/zig/include/stdarg.h:35:9
pub const va_arg = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg`"); // /opt/homebrew/Cellar/zig/0.11.0/lib/zig/include/stdarg.h:36:9
pub const __va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`"); // /opt/homebrew/Cellar/zig/0.11.0/lib/zig/include/stdarg.h:41:9
pub const va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`"); // /opt/homebrew/Cellar/zig/0.11.0/lib/zig/include/stdarg.h:46:9
pub const __llvm__ = @as(c_int, 1);
pub const __clang__ = @as(c_int, 1);
pub const __clang_major__ = @as(c_int, 16);
pub const __clang_minor__ = @as(c_int, 0);
pub const __clang_patchlevel__ = @as(c_int, 6);
pub const __clang_version__ = "16.0.6 ";
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = @as(c_int, 0);
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = @as(c_int, 1);
pub const __OPENCL_MEMORY_SCOPE_DEVICE = @as(c_int, 2);
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = @as(c_int, 3);
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = @as(c_int, 4);
pub const __PRAGMA_REDEFINE_EXTNAME = @as(c_int, 1);
pub const __VERSION__ = "Homebrew Clang 16.0.6";
pub const __OBJC_BOOL_IS_BOOL = @as(c_int, 0);
pub const __CONSTANT_CFSTRINGS__ = @as(c_int, 1);
pub const __clang_literal_encoding__ = "UTF-8";
pub const __clang_wide_literal_encoding__ = "UTF-16";
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const _ILP32 = @as(c_int, 1);
pub const __ILP32__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_WIDTH__ = @as(c_int, 32);
pub const __LLONG_WIDTH__ = @as(c_int, 64);
pub const __BITINT_MAXWIDTH__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 8388608, .decimal);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __INT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __LONG_MAX__ = @as(c_long, 2147483647);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __WCHAR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 16);
pub const __WINT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 16);
pub const __INTMAX_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 32);
pub const __UINTMAX_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 32);
pub const __INTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 32);
pub const __UINTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 32);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 4);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 4);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 4);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 4);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 2);
pub const __SIZEOF_WINT_T__ = @as(c_int, 2);
pub const __INTMAX_TYPE__ = c_longlong;
pub const __INTMAX_FMTd__ = "lld";
pub const __INTMAX_FMTi__ = "lli";
pub const __UINTMAX_TYPE__ = c_ulonglong;
pub const __UINTMAX_FMTo__ = "llo";
pub const __UINTMAX_FMTu__ = "llu";
pub const __UINTMAX_FMTx__ = "llx";
pub const __UINTMAX_FMTX__ = "llX";
pub const __PTRDIFF_TYPE__ = c_int;
pub const __PTRDIFF_FMTd__ = "d";
pub const __PTRDIFF_FMTi__ = "i";
pub const __INTPTR_TYPE__ = c_int;
pub const __INTPTR_FMTd__ = "d";
pub const __INTPTR_FMTi__ = "i";
pub const __SIZE_TYPE__ = c_uint;
pub const __SIZE_FMTo__ = "o";
pub const __SIZE_FMTu__ = "u";
pub const __SIZE_FMTx__ = "x";
pub const __SIZE_FMTX__ = "X";
pub const __WCHAR_TYPE__ = c_ushort;
pub const __WINT_TYPE__ = c_ushort;
pub const __SIG_ATOMIC_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __UINTPTR_TYPE__ = c_uint;
pub const __UINTPTR_FMTo__ = "o";
pub const __UINTPTR_FMTu__ = "u";
pub const __UINTPTR_FMTx__ = "x";
pub const __UINTPTR_FMTX__ = "X";
pub const __FLT16_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT16_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = @as(c_int, 1);
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __DBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 4.9406564584124654e-324);
pub const __LDBL_HAS_DENORM__ = @as(c_int, 1);
pub const __LDBL_DIG__ = @as(c_int, 15);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 2.2204460492503131e-16);
pub const __LDBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __LDBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __LDBL_MANT_DIG__ = @as(c_int, 53);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __LDBL_MAX_EXP__ = @as(c_int, 1024);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.7976931348623157e+308);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __LDBL_MIN__ = @as(c_longdouble, 2.2250738585072014e-308);
pub const __POINTER_WIDTH__ = @as(c_int, 32);
pub const __BIGGEST_ALIGNMENT__ = @as(c_int, 16);
pub const __WCHAR_UNSIGNED__ = @as(c_int, 1);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub const __INT64_TYPE__ = c_longlong;
pub const __INT64_FMTd__ = "lld";
pub const __INT64_FMTi__ = "lli";
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub const __UINT16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulonglong;
pub const __UINT64_FMTo__ = "llo";
pub const __UINT64_FMTu__ = "llu";
pub const __UINT64_FMTx__ = "llx";
pub const __UINT64_FMTX__ = "llX";
pub const __UINT64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __INT64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_LEAST8_FMTd__ = "hhd";
pub const __INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const __UINT_LEAST8_FMTo__ = "hho";
pub const __UINT_LEAST8_FMTu__ = "hhu";
pub const __UINT_LEAST8_FMTx__ = "hhx";
pub const __UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_LEAST16_FMTd__ = "hd";
pub const __INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_LEAST16_FMTo__ = "ho";
pub const __UINT_LEAST16_FMTu__ = "hu";
pub const __UINT_LEAST16_FMTx__ = "hx";
pub const __UINT_LEAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_LEAST32_FMTd__ = "d";
pub const __INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_LEAST32_FMTo__ = "o";
pub const __UINT_LEAST32_FMTu__ = "u";
pub const __UINT_LEAST32_FMTx__ = "x";
pub const __UINT_LEAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_longlong;
pub const __INT_LEAST64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_LEAST64_FMTd__ = "lld";
pub const __INT_LEAST64_FMTi__ = "lli";
pub const __UINT_LEAST64_TYPE__ = c_ulonglong;
pub const __UINT_LEAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINT_LEAST64_FMTo__ = "llo";
pub const __UINT_LEAST64_FMTu__ = "llu";
pub const __UINT_LEAST64_FMTx__ = "llx";
pub const __UINT_LEAST64_FMTX__ = "llX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_FAST8_FMTd__ = "hhd";
pub const __INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const __UINT_FAST8_FMTo__ = "hho";
pub const __UINT_FAST8_FMTu__ = "hhu";
pub const __UINT_FAST8_FMTx__ = "hhx";
pub const __UINT_FAST8_FMTX__ = "hhX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_FAST16_FMTd__ = "hd";
pub const __INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_FAST16_FMTo__ = "ho";
pub const __UINT_FAST16_FMTu__ = "hu";
pub const __UINT_FAST16_FMTx__ = "hx";
pub const __UINT_FAST16_FMTX__ = "hX";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_FAST32_FMTd__ = "d";
pub const __INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_FAST32_FMTo__ = "o";
pub const __UINT_FAST32_FMTu__ = "u";
pub const __UINT_FAST32_FMTx__ = "x";
pub const __UINT_FAST32_FMTX__ = "X";
pub const __INT_FAST64_TYPE__ = c_longlong;
pub const __INT_FAST64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_FAST64_FMTd__ = "lld";
pub const __INT_FAST64_FMTi__ = "lli";
pub const __UINT_FAST64_TYPE__ = c_ulonglong;
pub const __UINT_FAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINT_FAST64_FMTo__ = "llo";
pub const __UINT_FAST64_FMTu__ = "llu";
pub const __UINT_FAST64_FMTx__ = "llx";
pub const __UINT_FAST64_FMTX__ = "llX";
pub const __FINITE_MATH_ONLY__ = @as(c_int, 0);
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __NO_INLINE__ = @as(c_int, 1);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __GCC_ASM_FLAG_OUTPUTS__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const @"i386" = @as(c_int, 1);
pub const __i386 = @as(c_int, 1);
pub const __i386__ = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __pentium4 = @as(c_int, 1);
pub const __pentium4__ = @as(c_int, 1);
pub const __tune_pentium4__ = @as(c_int, 1);
pub const __REGISTER_PREFIX__ = "";
pub const __NO_MATH_INLINES = @as(c_int, 1);
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE2_MATH__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const _M_IX86_FP = @as(c_int, 2);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const _WIN32 = @as(c_int, 1);
pub const _M_FP_CONTRACT = @as(c_int, 1);
pub const _M_FP_PRECISE = @as(c_int, 1);
pub const _MSC_VER = @as(c_int, 1920);
pub const _MSC_FULL_VER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 192000000, .decimal);
pub const _MSC_BUILD = @as(c_int, 1);
pub const _MSC_EXTENSIONS = @as(c_int, 1);
pub const _ISO_VOLATILE = @as(c_int, 1);
pub const _INTEGRAL_MAX_BITS = @as(c_int, 64);
pub const __STDC_NO_THREADS__ = @as(c_int, 1);
pub const _MSVC_EXECUTION_CHARACTER_SET = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65001, .decimal);
pub const _M_IX86 = @as(c_int, 600);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const _DEBUG = @as(c_int, 1);
pub const __STDBOOL_H = "";
pub const __bool_true_false_are_defined = @as(c_int, 1);
pub const @"bool" = bool;
pub const @"true" = @as(c_int, 1);
pub const @"false" = @as(c_int, 0);
pub const __GNUC_VA_LIST = "";
pub const __STDARG_H = "";
pub const _VA_LIST = "";
pub const Unit_ = struct_Unit_;
pub const Player_ = struct_Player_;
pub const Region_ = struct_Region_;
pub const Force_ = struct_Force_;
pub const Bullet_ = struct_Bullet_;
pub const Game_ = struct_Game_;
pub const Client_ = struct_Client_;
pub const BwString_ = struct_BwString_;
pub const Iterator_ = struct_Iterator_;
pub const UnitIterator_ = struct_UnitIterator_;
pub const PlayerIterator_ = struct_PlayerIterator_;
pub const ForceIterator_ = struct_ForceIterator_;
pub const BulletIterator_ = struct_BulletIterator_;
pub const RegionIterator_ = struct_RegionIterator_;
pub const PositionIterator_ = struct_PositionIterator_;
pub const TilePositionIterator_ = struct_TilePositionIterator_;
pub const EventIterator_ = struct_EventIterator_;
pub const UnitTypeIterator_ = struct_UnitTypeIterator_;
pub const OscarModule_tag = struct_OscarModule_tag;
