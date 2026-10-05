/* Generated from the original bwenums.zig. BWAPI 4.2 id tables.
 * Enumerators carry a per-enum prefix because C enums share one namespace. */
#pragma once

#include "Types.h"

#ifdef __cplusplus
extern "C" {
#endif

#define UNIT_TYPE_LIST(X) \
    X(Terran_Marine) \
    X(Terran_Ghost) \
    X(Terran_Vulture) \
    X(Terran_Goliath) \
    X(Terran_Goliath_Turret) \
    X(Terran_Siege_Tank_Tank_Mode) \
    X(Terran_Siege_Tank_Tank_Mode_Turret) \
    X(Terran_SCV) \
    X(Terran_Wraith) \
    X(Terran_Science_Vessel) \
    X(Hero_Gui_Montag) \
    X(Terran_Dropship) \
    X(Terran_Battlecruiser) \
    X(Terran_Vulture_Spider_Mine) \
    X(Terran_Nuclear_Missile) \
    X(Terran_Civilian) \
    X(Hero_Sarah_Kerrigan) \
    X(Hero_Alan_Schezar) \
    X(Hero_Alan_Schezar_Turret) \
    X(Hero_Jim_Raynor_Vulture) \
    X(Hero_Jim_Raynor_Marine) \
    X(Hero_Tom_Kazansky) \
    X(Hero_Magellan) \
    X(Hero_Edmund_Duke_Tank_Mode) \
    X(Hero_Edmund_Duke_Tank_Mode_Turret) \
    X(Hero_Edmund_Duke_Siege_Mode) \
    X(Hero_Edmund_Duke_Siege_Mode_Turret) \
    X(Hero_Arcturus_Mengsk) \
    X(Hero_Hyperion) \
    X(Hero_Norad_II) \
    X(Terran_Siege_Tank_Siege_Mode) \
    X(Terran_Siege_Tank_Siege_Mode_Turret) \
    X(Terran_Firebat) \
    X(Spell_Scanner_Sweep) \
    X(Terran_Medic) \
    X(Zerg_Larva) \
    X(Zerg_Egg) \
    X(Zerg_Zergling) \
    X(Zerg_Hydralisk) \
    X(Zerg_Ultralisk) \
    X(Zerg_Broodling) \
    X(Zerg_Drone) \
    X(Zerg_Overlord) \
    X(Zerg_Mutalisk) \
    X(Zerg_Guardian) \
    X(Zerg_Queen) \
    X(Zerg_Defiler) \
    X(Zerg_Scourge) \
    X(Hero_Torrasque) \
    X(Hero_Matriarch) \
    X(Zerg_Infested_Terran) \
    X(Hero_Infested_Kerrigan) \
    X(Hero_Unclean_One) \
    X(Hero_Hunter_Killer) \
    X(Hero_Devouring_One) \
    X(Hero_Kukulza_Mutalisk) \
    X(Hero_Kukulza_Guardian) \
    X(Hero_Yggdrasill) \
    X(Terran_Valkyrie) \
    X(Zerg_Cocoon) \
    X(Protoss_Corsair) \
    X(Protoss_Dark_Templar) \
    X(Zerg_Devourer) \
    X(Protoss_Dark_Archon) \
    X(Protoss_Probe) \
    X(Protoss_Zealot) \
    X(Protoss_Dragoon) \
    X(Protoss_High_Templar) \
    X(Protoss_Archon) \
    X(Protoss_Shuttle) \
    X(Protoss_Scout) \
    X(Protoss_Arbiter) \
    X(Protoss_Carrier) \
    X(Protoss_Interceptor) \
    X(Hero_Dark_Templar) \
    X(Hero_Zeratul) \
    X(Hero_Tassadar_Zeratul_Archon) \
    X(Hero_Fenix_Zealot) \
    X(Hero_Fenix_Dragoon) \
    X(Hero_Tassadar) \
    X(Hero_Mojo) \
    X(Hero_Warbringer) \
    X(Hero_Gantrithor) \
    X(Protoss_Reaver) \
    X(Protoss_Observer) \
    X(Protoss_Scarab) \
    X(Hero_Danimoth) \
    X(Hero_Aldaris) \
    X(Hero_Artanis) \
    X(Critter_Rhynadon) \
    X(Critter_Bengalaas) \
    X(Special_Cargo_Ship) \
    X(Special_Mercenary_Gunship) \
    X(Critter_Scantid) \
    X(Critter_Kakaru) \
    X(Critter_Ragnasaur) \
    X(Critter_Ursadon) \
    X(Zerg_Lurker_Egg) \
    X(Hero_Raszagal) \
    X(Hero_Samir_Duran) \
    X(Hero_Alexei_Stukov) \
    X(Special_Map_Revealer) \
    X(Hero_Gerard_DuGalle) \
    X(Zerg_Lurker) \
    X(Hero_Infested_Duran) \
    X(Spell_Disruption_Web) \
    X(Terran_Command_Center) \
    X(Terran_Comsat_Station) \
    X(Terran_Nuclear_Silo) \
    X(Terran_Supply_Depot) \
    X(Terran_Refinery) \
    X(Terran_Barracks) \
    X(Terran_Academy) \
    X(Terran_Factory) \
    X(Terran_Starport) \
    X(Terran_Control_Tower) \
    X(Terran_Science_Facility) \
    X(Terran_Covert_Ops) \
    X(Terran_Physics_Lab) \
    X(Unused_Terran1) \
    X(Terran_Machine_Shop) \
    X(Unused_Terran2) \
    X(Terran_Engineering_Bay) \
    X(Terran_Armory) \
    X(Terran_Missile_Turret) \
    X(Terran_Bunker) \
    X(Special_Crashed_Norad_II) \
    X(Special_Ion_Cannon) \
    X(Powerup_Uraj_Crystal) \
    X(Powerup_Khalis_Crystal) \
    X(Zerg_Infested_Command_Center) \
    X(Zerg_Hatchery) \
    X(Zerg_Lair) \
    X(Zerg_Hive) \
    X(Zerg_Nydus_Canal) \
    X(Zerg_Hydralisk_Den) \
    X(Zerg_Defiler_Mound) \
    X(Zerg_Greater_Spire) \
    X(Zerg_Queens_Nest) \
    X(Zerg_Evolution_Chamber) \
    X(Zerg_Ultralisk_Cavern) \
    X(Zerg_Spire) \
    X(Zerg_Spawning_Pool) \
    X(Zerg_Creep_Colony) \
    X(Zerg_Spore_Colony) \
    X(Unused_Zerg1) \
    X(Zerg_Sunken_Colony) \
    X(Special_Overmind_With_Shell) \
    X(Special_Overmind) \
    X(Zerg_Extractor) \
    X(Special_Mature_Chrysalis) \
    X(Special_Cerebrate) \
    X(Special_Cerebrate_Daggoth) \
    X(Unused_Zerg2) \
    X(Protoss_Nexus) \
    X(Protoss_Robotics_Facility) \
    X(Protoss_Pylon) \
    X(Protoss_Assimilator) \
    X(Unused_Protoss1) \
    X(Protoss_Observatory) \
    X(Protoss_Gateway) \
    X(Unused_Protoss2) \
    X(Protoss_Photon_Cannon) \
    X(Protoss_Citadel_of_Adun) \
    X(Protoss_Cybernetics_Core) \
    X(Protoss_Templar_Archives) \
    X(Protoss_Forge) \
    X(Protoss_Stargate) \
    X(Special_Stasis_Cell_Prison) \
    X(Protoss_Fleet_Beacon) \
    X(Protoss_Arbiter_Tribunal) \
    X(Protoss_Robotics_Support_Bay) \
    X(Protoss_Shield_Battery) \
    X(Special_Khaydarin_Crystal_Form) \
    X(Special_Protoss_Temple) \
    X(Special_XelNaga_Temple) \
    X(Resource_Mineral_Field) \
    X(Resource_Mineral_Field_Type_2) \
    X(Resource_Mineral_Field_Type_3) \
    X(Unused_Cave) \
    X(Unused_Cave_In) \
    X(Unused_Cantina) \
    X(Unused_Mining_Platform) \
    X(Unused_Independant_Command_Center) \
    X(Special_Independant_Starport) \
    X(Unused_Independant_Jump_Gate) \
    X(Unused_Ruins) \
    X(Unused_Khaydarin_Crystal_Formation) \
    X(Resource_Vespene_Geyser) \
    X(Special_Warp_Gate) \
    X(Special_Psi_Disrupter) \
    X(Unused_Zerg_Marker) \
    X(Unused_Terran_Marker) \
    X(Unused_Protoss_Marker) \
    X(Special_Zerg_Beacon) \
    X(Special_Terran_Beacon) \
    X(Special_Protoss_Beacon) \
    X(Special_Zerg_Flag_Beacon) \
    X(Special_Terran_Flag_Beacon) \
    X(Special_Protoss_Flag_Beacon) \
    X(Special_Power_Generator) \
    X(Special_Overmind_Cocoon) \
    X(Spell_Dark_Swarm) \
    X(Special_Floor_Missile_Trap) \
    X(Special_Floor_Hatch) \
    X(Special_Upper_Level_Door) \
    X(Special_Right_Upper_Level_Door) \
    X(Special_Pit_Door) \
    X(Special_Right_Pit_Door) \
    X(Special_Floor_Gun_Trap) \
    X(Special_Wall_Missile_Trap) \
    X(Special_Wall_Flame_Trap) \
    X(Special_Right_Wall_Missile_Trap) \
    X(Special_Right_Wall_Flame_Trap) \
    X(Special_Start_Location) \
    X(Powerup_Flag) \
    X(Powerup_Young_Chrysalis) \
    X(Powerup_Psi_Emitter) \
    X(Powerup_Data_Disk) \
    X(Powerup_Khaydarin_Crystal) \
    X(Powerup_Mineral_Cluster_Type_1) \
    X(Powerup_Mineral_Cluster_Type_2) \
    X(Powerup_Protoss_Gas_Orb_Type_1) \
    X(Powerup_Protoss_Gas_Orb_Type_2) \
    X(Powerup_Zerg_Gas_Sac_Type_1) \
    X(Powerup_Zerg_Gas_Sac_Type_2) \
    X(Powerup_Terran_Gas_Tank_Type_1) \
    X(Powerup_Terran_Gas_Tank_Type_2) \
    X(None) \
    X(AllUnits) \
    X(Men) \
    X(Buildings) \
    X(Factories) \
    X(Unknown) \
    X(MAX) \
    /* end */

typedef enum UnitTypeId {
#define X(n) UT_##n,
    UNIT_TYPE_LIST(X)
#undef X
} UnitTypeId;

extern const char* const UnitTypeNames[UT_MAX + 1];

typedef enum RaceId {
    RACE_Zerg,
    RACE_Terran,
    RACE_Protoss,
    RACE_Other,
    RACE_Unused,
    RACE_Select,
    RACE_Random,
    RACE_None,
    RACE_Unknown,
    RACE_MAX,
} RaceId;

typedef enum ErrorsId {
    ERR_Unit_Does_Not_Exist,
    ERR_Unit_Not_Visible,
    ERR_Unit_Not_Owned,
    ERR_Unit_Busy,
    ERR_Incompatible_UnitType,
    ERR_Incompatible_TechType,
    ERR_Incompatible_State,
    ERR_Already_Researched,
    ERR_Fully_Upgraded,
    ERR_Currently_Researching,
    ERR_Currently_Upgrading,
    ERR_Insufficient_Minerals,
    ERR_Insufficient_Gas,
    ERR_Insufficient_Supply,
    ERR_Insufficient_Energy,
    ERR_Insufficient_Tech,
    ERR_Insufficient_Ammo,
    ERR_Insufficient_Space,
    ERR_Invalid_Tile_Position,
    ERR_Unbuildable_Location,
    ERR_Unreachable_Location,
    ERR_Out_Of_Range,
    ERR_Unable_To_Hit,
    ERR_Access_Denied,
    ERR_File_Not_Found,
    ERR_Invalid_Parameter,
    ERR_None,
    ERR_Unknown,
    ERR_MAX,
} ErrorsId;

typedef enum TechTypesId {
    TECH_Stim_Packs,
    TECH_Lockdown,
    TECH_EMP_Shockwave,
    TECH_Spider_Mines,
    TECH_Scanner_Sweep,
    TECH_Tank_Siege_Mode,
    TECH_Defensive_Matrix,
    TECH_Irradiate,
    TECH_Yamato_Gun,
    TECH_Cloaking_Field,
    TECH_Personnel_Cloaking,
    TECH_Burrowing,
    TECH_Infestation,
    TECH_Spawn_Broodlings,
    TECH_Dark_Swarm,
    TECH_Plague,
    TECH_Consume,
    TECH_Ensnare,
    TECH_Parasite,
    TECH_Psionic_Storm,
    TECH_Hallucination,
    TECH_Recall,
    TECH_Stasis_Field,
    TECH_Archon_Warp,
    TECH_Restoration,
    TECH_Disruption_Web,
    TECH_Unused_26,
    TECH_Mind_Control,
    TECH_Dark_Archon_Meld,
    TECH_Feedback,
    TECH_Optical_Flare,
    TECH_Maelstrom,
    TECH_Lurker_Aspect,
    TECH_Unused_33,
    TECH_Healing,
    TECH_None = 44,
    TECH_Nuclear_Strike,
    TECH_Unknown,
    TECH_MAX,
} TechTypesId;

typedef enum OrdersId {
    ORDER_Die,
    ORDER_Stop,
    ORDER_Guard,
    ORDER_PlayerGuard,
    ORDER_TurretGuard,
    ORDER_BunkerGuard,
    ORDER_Move,
    ORDER_ReaverStop,
    ORDER_Attack1,
    ORDER_Attack2,
    ORDER_AttackUnit,
    ORDER_AttackFixedRange,
    ORDER_AttackTile,
    ORDER_Hover,
    ORDER_AttackMove,
    ORDER_InfestedCommandCenter,
    ORDER_UnusedNothing,
    ORDER_UnusedPowerup,
    ORDER_TowerGuard,
    ORDER_TowerAttack,
    ORDER_VultureMine,
    ORDER_StayInRange,
    ORDER_TurretAttack,
    ORDER_Nothing,
    ORDER_Unused_24,
    ORDER_DroneStartBuild,
    ORDER_DroneBuild,
    ORDER_CastInfestation,
    ORDER_MoveToInfest,
    ORDER_InfestingCommandCenter,
    ORDER_PlaceBuilding,
    ORDER_PlaceProtossBuilding,
    ORDER_CreateProtossBuilding,
    ORDER_ConstructingBuilding,
    ORDER_Repair,
    ORDER_MoveToRepair,
    ORDER_PlaceAddon,
    ORDER_BuildAddon,
    ORDER_Train,
    ORDER_RallyPointUnit,
    ORDER_RallyPointTile,
    ORDER_ZergBirth,
    ORDER_ZergUnitMorph,
    ORDER_ZergBuildingMorph,
    ORDER_IncompleteBuilding,
    ORDER_IncompleteMorphing,
    ORDER_BuildNydusExit,
    ORDER_EnterNydusCanal,
    ORDER_IncompleteWarping,
    ORDER_Follow,
    ORDER_Carrier,
    ORDER_ReaverCarrierMove,
    ORDER_CarrierStop,
    ORDER_CarrierAttack,
    ORDER_CarrierMoveToAttack,
    ORDER_CarrierIgnore2,
    ORDER_CarrierFight,
    ORDER_CarrierHoldPosition,
    ORDER_Reaver,
    ORDER_ReaverAttack,
    ORDER_ReaverMoveToAttack,
    ORDER_ReaverFight,
    ORDER_ReaverHoldPosition,
    ORDER_TrainFighter,
    ORDER_InterceptorAttack,
    ORDER_ScarabAttack,
    ORDER_RechargeShieldsUnit,
    ORDER_RechargeShieldsBattery,
    ORDER_ShieldBattery,
    ORDER_InterceptorReturn,
    ORDER_DroneLand,
    ORDER_BuildingLand,
    ORDER_BuildingLiftOff,
    ORDER_DroneLiftOff,
    ORDER_LiftingOff,
    ORDER_ResearchTech,
    ORDER_Upgrade,
    ORDER_Larva,
    ORDER_SpawningLarva,
    ORDER_Harvest1,
    ORDER_Harvest2,
    ORDER_MoveToGas,
    ORDER_WaitForGas,
    ORDER_HarvestGas,
    ORDER_ReturnGas,
    ORDER_MoveToMinerals,
    ORDER_WaitForMinerals,
    ORDER_MiningMinerals,
    ORDER_Harvest3,
    ORDER_Harvest4,
    ORDER_ReturnMinerals,
    ORDER_Interrupted,
    ORDER_EnterTransport,
    ORDER_PickupIdle,
    ORDER_PickupTransport,
    ORDER_PickupBunker,
    ORDER_Pickup4,
    ORDER_PowerupIdle,
    ORDER_Sieging,
    ORDER_Unsieging,
    ORDER_WatchTarget,
    ORDER_InitCreepGrowth,
    ORDER_SpreadCreep,
    ORDER_StoppingCreepGrowth,
    ORDER_GuardianAspect,
    ORDER_ArchonWarp,
    ORDER_CompletingArchonSummon,
    ORDER_HoldPosition,
    ORDER_QueenHoldPosition,
    ORDER_Cloak,
    ORDER_Decloak,
    ORDER_Unload,
    ORDER_MoveUnload,
    ORDER_FireYamatoGun,
    ORDER_MoveToFireYamatoGun,
    ORDER_CastLockdown,
    ORDER_Burrowing,
    ORDER_Burrowed,
    ORDER_Unburrowing,
    ORDER_CastDarkSwarm,
    ORDER_CastParasite,
    ORDER_CastSpawnBroodlings,
    ORDER_CastEMPShockwave,
    ORDER_NukeWait,
    ORDER_NukeTrain,
    ORDER_NukeLaunch,
    ORDER_NukePaint,
    ORDER_NukeUnit,
    ORDER_CastNuclearStrike,
    ORDER_NukeTrack,
    ORDER_InitializeArbiter,
    ORDER_CloakNearbyUnits,
    ORDER_PlaceMine,
    ORDER_RightClickAction,
    ORDER_SuicideUnit,
    ORDER_SuicideLocation,
    ORDER_SuicideHoldPosition,
    ORDER_CastRecall,
    ORDER_Teleport,
    ORDER_CastScannerSweep,
    ORDER_Scanner,
    ORDER_CastDefensiveMatrix,
    ORDER_CastPsionicStorm,
    ORDER_CastIrradiate,
    ORDER_CastPlague,
    ORDER_CastConsume,
    ORDER_CastEnsnare,
    ORDER_CastStasisField,
    ORDER_CastHallucination,
    ORDER_Hallucination2,
    ORDER_ResetCollision,
    ORDER_ResetHarvestCollision,
    ORDER_Patrol,
    ORDER_CTFCOPInit,
    ORDER_CTFCOPStarted,
    ORDER_CTFCOP2,
    ORDER_ComputerAI,
    ORDER_AtkMoveEP,
    ORDER_HarassMove,
    ORDER_AIPatrol,
    ORDER_GuardPost,
    ORDER_RescuePassive,
    ORDER_Neutral,
    ORDER_ComputerReturn,
    ORDER_InitializePsiProvider,
    ORDER_SelfDestructing,
    ORDER_Critter,
    ORDER_HiddenGun,
    ORDER_OpenDoor,
    ORDER_CloseDoor,
    ORDER_HideTrap,
    ORDER_RevealTrap,
    ORDER_EnableDoodad,
    ORDER_DisableDoodad,
    ORDER_WarpIn,
    ORDER_Medic,
    ORDER_MedicHeal,
    ORDER_HealMove,
    ORDER_MedicHoldPosition,
    ORDER_MedicHealToIdle,
    ORDER_CastRestoration,
    ORDER_CastDisruptionWeb,
    ORDER_CastMindControl,
    ORDER_DarkArchonMeld,
    ORDER_CastFeedback,
    ORDER_CastOpticalFlare,
    ORDER_CastMaelstrom,
    ORDER_JunkYardDog,
    ORDER_Fatal,
    ORDER_None,
    ORDER_Unknown,
    ORDER_MAX,
} OrdersId;

typedef enum UnitCommandTypeId {
    UCT_Attack_Move = 0,
    UCT_Attack_Unit,
    UCT_Build,
    UCT_Build_Addon,
    UCT_Train,
    UCT_Morph,
    UCT_Research,
    UCT_Upgrade,
    UCT_Set_Rally_Position,
    UCT_Set_Rally_Unit,
    UCT_Move,
    UCT_Patrol,
    UCT_Hold_Position,
    UCT_Stop,
    UCT_Follow,
    UCT_Gather,
    UCT_Return_Cargo,
    UCT_Repair,
    UCT_Burrow,
    UCT_Unburrow,
    UCT_Cloak,
    UCT_Decloak,
    UCT_Siege,
    UCT_Unsiege,
    UCT_Lift,
    UCT_Land,
    UCT_Load,
    UCT_Unload,
    UCT_Unload_All,
    UCT_Unload_All_Position,
    UCT_Right_Click_Position,
    UCT_Right_Click_Unit,
    UCT_Halt_Construction,
    UCT_Cancel_Construction,
    UCT_Cancel_Addon,
    UCT_Cancel_Train,
    UCT_Cancel_Train_Slot,
    UCT_Cancel_Morph,
    UCT_Cancel_Research,
    UCT_Cancel_Upgrade,
    UCT_Use_Tech,
    UCT_Use_Tech_Position,
    UCT_Use_Tech_Unit,
    UCT_Place_COP,
    UCT_None,
    UCT_Unknown,
    UCT_MAX,
} UnitCommandTypeId;

typedef enum UpgradeTypesId {
    UPG_Terran_Infantry_Armor = 0,
    UPG_Terran_Vehicle_Plating = 1,
    UPG_Terran_Ship_Plating = 2,
    UPG_Zerg_Carapace = 3,
    UPG_Zerg_Flyer_Carapace = 4,
    UPG_Protoss_Ground_Armor = 5,
    UPG_Protoss_Air_Armor = 6,
    UPG_Terran_Infantry_Weapons = 7,
    UPG_Terran_Vehicle_Weapons = 8,
    UPG_Terran_Ship_Weapons = 9,
    UPG_Zerg_Melee_Attacks = 10,
    UPG_Zerg_Missile_Attacks = 11,
    UPG_Zerg_Flyer_Attacks = 12,
    UPG_Protoss_Ground_Weapons = 13,
    UPG_Protoss_Air_Weapons = 14,
    UPG_Protoss_Plasma_Shields = 15,
    UPG_U_238_Shells = 16,
    UPG_Ion_Thrusters = 17,
    UPG_Titan_Reactor = 19,
    UPG_Ocular_Implants = 20,
    UPG_Moebius_Reactor = 21,
    UPG_Apollo_Reactor = 22,
    UPG_Colossus_Reactor = 23,
    UPG_Ventral_Sacs = 24,
    UPG_Antennae = 25,
    UPG_Pneumatized_Carapace = 26,
    UPG_Metabolic_Boost = 27,
    UPG_Adrenal_Glands = 28,
    UPG_Muscular_Augments = 29,
    UPG_Grooved_Spines = 30,
    UPG_Gamete_Meiosis = 31,
    UPG_Metasynaptic_Node = 32,
    UPG_Singularity_Charge = 33,
    UPG_Leg_Enhancements = 34,
    UPG_Scarab_Damage = 35,
    UPG_Reaver_Capacity = 36,
    UPG_Gravitic_Drive = 37,
    UPG_Sensor_Array = 38,
    UPG_Gravitic_Boosters = 39,
    UPG_Khaydarin_Amulet = 40,
    UPG_Apial_Sensors = 41,
    UPG_Gravitic_Thrusters = 42,
    UPG_Carrier_Capacity = 43,
    UPG_Khaydarin_Core = 44,
    UPG_Argus_Jewel = 47,
    UPG_Argus_Talisman = 49,
    UPG_Caduceus_Reactor = 51,
    UPG_Chitinous_Plating = 52,
    UPG_Anabolic_Synthesis = 53,
    UPG_Charon_Boosters = 54,
    UPG_Upgrade_60 = 60,
    UPG_None = 61,
    UPG_Unknown,
    UPG_MAX,
} UpgradeTypesId;

/* WhatBuilds[unit] is the unit type that produces/morphs into that unit. */
extern const UnitTypeId WhatBuilds[UT_MAX];

#ifdef __cplusplus
}
#endif
