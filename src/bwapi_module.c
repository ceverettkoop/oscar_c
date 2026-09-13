/* DLL entry points BWAPI looks up by name (gameInit, newAIModule) and the
 * AIModule vtable that forwards game callbacks into the bot. */

#include <stdlib.h>

#include "AIModule.h"
#include "Game.h"
#include "bwenums.h"
#include "directive.h"
#include "gamestate.h"
#include "oscar.h"
#include "util.h"

#if defined(_WIN32)
#  define BWAPI_EXPORT __declspec(dllexport)
#else
#  define BWAPI_EXPORT __attribute__((visibility("default")))
#endif

/* Relative to the game's working directory (the starcraft folder). */
static const char* const script_path = "../script/test_directives";

typedef struct OscarModule {
    const AIModule_vtable* vtable; /* must be first: BWAPIC reads it through AIModule* */
    const char*            name;
} OscarModule;

static Game*      broodwar;
static GameState* game_state; /* only global ideally */

static void on_start(AIModule* self)
{
    OscarModule* module = (OscarModule*)self;
    Game_sendText(broodwar, "Hello from C!");
    Game_sendText(broodwar, "My name is %s", module->name);

    game_state = calloc(1, sizeof *game_state);
    if (!game_state) { LOG("out of memory allocating game state\n"); return; }
    gamestate_init(game_state, broodwar);

    /* cry if not zerg */
    if (game_state->self_race != RACE_Zerg)
        Game_sendText(broodwar, "I am not zerg so no clue :(");

    Directive* parsed;
    size_t count;
    ParseError err = parse_directive_file(script_path, &parsed, &count);
    if (err != PARSE_OK) {
        Game_sendText(broodwar, "Error parsing directives: %s", parse_error_name(err));
        return;
    }
    for (size_t i = 0; i < count; i++) {
        if (vec_push(&game_state->directive_list, parsed[i])) {
            Game_sendText(broodwar, "Error loading directives: out of memory");
            break;
        }
    }
    free(parsed);
    Game_sendText(broodwar, "Loaded %d directives", (int)game_state->directive_list.len);
}

static void on_end(AIModule* self, bool is_winner)
{
    (void)self; (void)is_winner;
    Game_sendText(broodwar, "Game ended");
    if (game_state) {
        gamestate_deinit(game_state);
        free(game_state);
        game_state = NULL;
    }
}

static void on_frame(AIModule* self)
{
    (void)self;
    if (!game_state) return;
    oscar_on_frame(broodwar, game_state);
}

static void on_send_text(AIModule* self, const char* text)              { (void)self; (void)text; }
static void on_receive_text(AIModule* self, Player* p, const char* text) { (void)self; (void)p; (void)text; }
static void on_player_left(AIModule* self, Player* p)                    { (void)self; (void)p; }
static void on_nuke_detect(AIModule* self, Position target)              { (void)self; (void)target; }
static void on_unit_discover(AIModule* self, Unit* u)                    { (void)self; (void)u; }
static void on_unit_evade(AIModule* self, Unit* u)                       { (void)self; (void)u; }
static void on_unit_show(AIModule* self, Unit* u)                        { (void)self; (void)u; }
static void on_unit_hide(AIModule* self, Unit* u)                        { (void)self; (void)u; }
static void on_unit_create(AIModule* self, Unit* u)                      { (void)self; (void)u; }
static void on_unit_destroy(AIModule* self, Unit* u)                     { (void)self; (void)u; }
static void on_unit_morph(AIModule* self, Unit* u)                       { (void)self; (void)u; }
static void on_unit_renegade(AIModule* self, Unit* u)                    { (void)self; (void)u; }
static void on_save_game(AIModule* self, const char* name)               { (void)self; (void)name; }
static void on_unit_complete(AIModule* self, Unit* u)                    { (void)self; (void)u; }

static const AIModule_vtable module_vtable = {
    .onStart        = on_start,
    .onEnd          = on_end,
    .onFrame        = on_frame,
    .onSendText     = on_send_text,
    .onReceiveText  = on_receive_text,
    .onPlayerLeft   = on_player_left,
    .onNukeDetect   = on_nuke_detect,
    .onUnitDiscover = on_unit_discover,
    .onUnitEvade    = on_unit_evade,
    .onUnitShow     = on_unit_show,
    .onUnitHide     = on_unit_hide,
    .onUnitCreate   = on_unit_create,
    .onUnitDestroy  = on_unit_destroy,
    .onUnitMorph    = on_unit_morph,
    .onUnitRenegade = on_unit_renegade,
    .onSaveGame     = on_save_game,
    .onUnitComplete = on_unit_complete,
};

BWAPI_EXPORT void gameInit(void* game)
{
    broodwar = (Game*)game;
    BWAPIC_setGame(broodwar);
}

BWAPI_EXPORT void* newAIModule(void)
{
    OscarModule* module = calloc(1, sizeof *module);
    if (!module) return NULL;
    module->vtable = &module_vtable;
    module->name = "oscar";
    return createAIModuleWrapper((AIModule*)module);
}
