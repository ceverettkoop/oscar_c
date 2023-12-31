#include <AIModule.h>
#include <Game.h>
#include <Iterator.h>
#include <Unit.h>
#include <Player.h>
#include <Event.h>

typedef struct BWAPI_Game BWAPI_Game; // BWAPI::Game
typedef struct BWAPI_AIModule BWAPI_AIModule; // BWAPI::AIModule

static Game* Broodwar;

typedef struct OscarModule_tag{
    const AIModule_vtable* vtable_;
    const char* name;
} OscarModule;

void onStart(AIModule* self) {
    OscarModule* module = (OscarModule*) self;
    Game_sendText(Broodwar, "Hello from bwapi-c!");
    Game_sendText(Broodwar, "My name is %s", module->name);
}
void onEnd(AIModule* module, bool isWinner) {
    Game_sendText(Broodwar, "Game ended");
}

void onFrame(AIModule* self) {
    const int frame_count = Game_getFrameCount(Broodwar);
    CoordinateType CoordinateType_None = { .id = 0 };
    Game_drawText(Broodwar, CoordinateType_None, 10, 10, "Frame %d", frame_count);
}

void onSendText(AIModule* module, const char* text) {}
void onReceiveText(AIModule* module, Player* player, const char* text) {}
void onPlayerLeft(AIModule* module, Player* player) {}
void onNukeDetect(AIModule* module, Position target) {}
void onUnitDiscover(AIModule* module, Unit* unit) {}
void onUnitEvade(AIModule* module, Unit* unit) {}
void onUnitShow(AIModule* module, Unit* unit) {}
void onUnitHide(AIModule* module, Unit* unit) {}
void onUnitCreate(AIModule* module, Unit* unit) {}
void onUnitDestroy(AIModule* module, Unit* unit) {}
void onUnitMorph(AIModule* module, Unit* unit) {}
void onUnitRenegade(AIModule* module, Unit* unit) {}
void onSaveGame(AIModule* module, const char* gameName) {}
void onUnitComplete(AIModule* module, Unit* unit) {}

static AIModule_vtable module_vtable = {
    onStart,
    onEnd,
    onFrame,
    onSendText,
    onReceiveText,
    onPlayerLeft,
    onNukeDetect,
    onUnitDiscover,
    onUnitEvade,
    onUnitShow,
    onUnitHide,
    onUnitCreate,
    onUnitDestroy,
    onUnitMorph,
    onUnitRenegade,
    onSaveGame,
    onUnitComplete
};

//this gets DLLEXPORT
void DLLEXPORTME_gameInit(BWAPI_Game* game) {
    Broodwar = (Game*) game;
    BWAPIC_setGame(Broodwar);
}

//this gets DLLEXPORT
BWAPI_AIModule* DLLEXPORTME_newAIModule() {
    OscarModule* const module = (OscarModule*)666; //666 is flag to change to zig allocation
    module->name = "OscarModule";
    module->vtable_ = &module_vtable;

    return (BWAPI_AIModule*) createAIModuleWrapper( (AIModule*) module );
}
