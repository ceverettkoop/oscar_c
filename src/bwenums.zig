//event type enum stored in events.zig
//other relevant types here, a few are missing bc not expected to implement

pub const UnitType = enum(c_int){
    Terran_Marine,
    Terran_Ghost,
    Terran_Vulture,
    Terran_Goliath,
    Terran_Goliath_Turret,
    Terran_Siege_Tank_Tank_Mode,
    Terran_Siege_Tank_Tank_Mode_Turret,
    Terran_SCV,
    Terran_Wraith,
    Terran_Science_Vessel,
    Hero_Gui_Montag,
    Terran_Dropship,
    Terran_Battlecruiser,
    Terran_Vulture_Spider_Mine,
    Terran_Nuclear_Missile,
    Terran_Civilian,
    Hero_Sarah_Kerrigan,
    Hero_Alan_Schezar,
    Hero_Alan_Schezar_Turret,
    Hero_Jim_Raynor_Vulture,
    Hero_Jim_Raynor_Marine,
    Hero_Tom_Kazansky,
    Hero_Magellan,
    Hero_Edmund_Duke_Tank_Mode,
    Hero_Edmund_Duke_Tank_Mode_Turret,
    Hero_Edmund_Duke_Siege_Mode,
    Hero_Edmund_Duke_Siege_Mode_Turret,
    Hero_Arcturus_Mengsk,
    Hero_Hyperion,
    Hero_Norad_II,
    Terran_Siege_Tank_Siege_Mode,
    Terran_Siege_Tank_Siege_Mode_Turret,
    Terran_Firebat,
    Spell_Scanner_Sweep,
    Terran_Medic,
    Zerg_Larva,
    Zerg_Egg,
    Zerg_Zergling,
    Zerg_Hydralisk,
    Zerg_Ultralisk,
    Zerg_Broodling,
    Zerg_Drone,
    Zerg_Overlord,
    Zerg_Mutalisk,
    Zerg_Guardian,
    Zerg_Queen,
    Zerg_Defiler,
    Zerg_Scourge,
    Hero_Torrasque,
    Hero_Matriarch,
    Zerg_Infested_Terran,
    Hero_Infested_Kerrigan,
    Hero_Unclean_One,
    Hero_Hunter_Killer,
    Hero_Devouring_One,
    Hero_Kukulza_Mutalisk,
    Hero_Kukulza_Guardian,
    Hero_Yggdrasill,
    Terran_Valkyrie,
    Zerg_Cocoon,
    Protoss_Corsair,
    Protoss_Dark_Templar,
    Zerg_Devourer,
    Protoss_Dark_Archon,
    Protoss_Probe,
    Protoss_Zealot,
    Protoss_Dragoon,
    Protoss_High_Templar,
    Protoss_Archon,
    Protoss_Shuttle,
    Protoss_Scout,
    Protoss_Arbiter,
    Protoss_Carrier,
    Protoss_Interceptor,
    Hero_Dark_Templar,
    Hero_Zeratul,
    Hero_Tassadar_Zeratul_Archon,
    Hero_Fenix_Zealot,
    Hero_Fenix_Dragoon,
    Hero_Tassadar,
    Hero_Mojo,
    Hero_Warbringer,
    Hero_Gantrithor,
    Protoss_Reaver,
    Protoss_Observer,
    Protoss_Scarab,
    Hero_Danimoth,
    Hero_Aldaris,
    Hero_Artanis,
    Critter_Rhynadon,
    Critter_Bengalaas,
    Special_Cargo_Ship,
    Special_Mercenary_Gunship,
    Critter_Scantid,
    Critter_Kakaru,
    Critter_Ragnasaur,
    Critter_Ursadon,
    Zerg_Lurker_Egg,
    Hero_Raszagal,
    Hero_Samir_Duran,
    Hero_Alexei_Stukov,
    Special_Map_Revealer,
    Hero_Gerard_DuGalle,
    Zerg_Lurker,
    Hero_Infested_Duran,
    Spell_Disruption_Web,
    Terran_Command_Center,
    Terran_Comsat_Station,
    Terran_Nuclear_Silo,
    Terran_Supply_Depot,
    Terran_Refinery,
    Terran_Barracks,
    Terran_Academy,
    Terran_Factory,
    Terran_Starport,
    Terran_Control_Tower,
    Terran_Science_Facility,
    Terran_Covert_Ops,
    Terran_Physics_Lab,
    Unused_Terran1,
    Terran_Machine_Shop,
    Unused_Terran2,
    Terran_Engineering_Bay,
    Terran_Armory,
    Terran_Missile_Turret,
    Terran_Bunker,
    Special_Crashed_Norad_II,
    Special_Ion_Cannon,
    Powerup_Uraj_Crystal,
    Powerup_Khalis_Crystal,
    Zerg_Infested_Command_Center,
    Zerg_Hatchery,
    Zerg_Lair,
    Zerg_Hive,
    Zerg_Nydus_Canal,
    Zerg_Hydralisk_Den,
    Zerg_Defiler_Mound,
    Zerg_Greater_Spire,
    Zerg_Queens_Nest,
    Zerg_Evolution_Chamber,
    Zerg_Ultralisk_Cavern,
    Zerg_Spire,
    Zerg_Spawning_Pool,
    Zerg_Creep_Colony,
    Zerg_Spore_Colony,
    Unused_Zerg1,
    Zerg_Sunken_Colony,
    Special_Overmind_With_Shell,
    Special_Overmind,
    Zerg_Extractor,
    Special_Mature_Chrysalis,
    Special_Cerebrate,
    Special_Cerebrate_Daggoth,
    Unused_Zerg2,
    Protoss_Nexus,
    Protoss_Robotics_Facility,
    Protoss_Pylon,
    Protoss_Assimilator,
    Unused_Protoss1,
    Protoss_Observatory,
    Protoss_Gateway,
    Unused_Protoss2,
    Protoss_Photon_Cannon,
    Protoss_Citadel_of_Adun,
    Protoss_Cybernetics_Core,
    Protoss_Templar_Archives,
    Protoss_Forge,
    Protoss_Stargate,
    Special_Stasis_Cell_Prison,
    Protoss_Fleet_Beacon,
    Protoss_Arbiter_Tribunal,
    Protoss_Robotics_Support_Bay,
    Protoss_Shield_Battery,
    Special_Khaydarin_Crystal_Form,
    Special_Protoss_Temple,
    Special_XelNaga_Temple,
    Resource_Mineral_Field,
    Resource_Mineral_Field_Type_2,
    Resource_Mineral_Field_Type_3,
    Unused_Cave,
    Unused_Cave_In,
    Unused_Cantina,
    Unused_Mining_Platform,
    Unused_Independant_Command_Center,
    Special_Independant_Starport,
    Unused_Independant_Jump_Gate,
    Unused_Ruins,
    Unused_Khaydarin_Crystal_Formation,
    Resource_Vespene_Geyser,
    Special_Warp_Gate,
    Special_Psi_Disrupter,
    Unused_Zerg_Marker,
    Unused_Terran_Marker,
    Unused_Protoss_Marker,
    Special_Zerg_Beacon,
    Special_Terran_Beacon,
    Special_Protoss_Beacon,
    Special_Zerg_Flag_Beacon,
    Special_Terran_Flag_Beacon,
    Special_Protoss_Flag_Beacon,
    Special_Power_Generator,
    Special_Overmind_Cocoon,
    Spell_Dark_Swarm,
    Special_Floor_Missile_Trap,
    Special_Floor_Hatch,
    Special_Upper_Level_Door,
    Special_Right_Upper_Level_Door,
    Special_Pit_Door,
    Special_Right_Pit_Door,
    Special_Floor_Gun_Trap,
    Special_Wall_Missile_Trap,
    Special_Wall_Flame_Trap,
    Special_Right_Wall_Missile_Trap,
    Special_Right_Wall_Flame_Trap,
    Special_Start_Location,
    Powerup_Flag,
    Powerup_Young_Chrysalis,
    Powerup_Psi_Emitter,
    Powerup_Data_Disk,
    Powerup_Khaydarin_Crystal,
    Powerup_Mineral_Cluster_Type_1,
    Powerup_Mineral_Cluster_Type_2,
    Powerup_Protoss_Gas_Orb_Type_1,
    Powerup_Protoss_Gas_Orb_Type_2,
    Powerup_Zerg_Gas_Sac_Type_1,
    Powerup_Zerg_Gas_Sac_Type_2,
    Powerup_Terran_Gas_Tank_Type_1,
    Powerup_Terran_Gas_Tank_Type_2,
    None,
    AllUnits,
    Men,
    Buildings,
    Factories,
    Unknown,
    MAX
};

pub const Race = enum(c_int){
    Zerg,
    Terran,
    Protoss,
    Other,
    Unused,
    Select,
    Random,
    None,
    Unknown,
    MAX
};

pub const Errors = enum(c_int){
    Unit_Does_Not_Exist,
    Unit_Not_Visible,
    Unit_Not_Owned,
    Unit_Busy,
    Incompatible_UnitType,
    Incompatible_TechType,
    Incompatible_State,
    Already_Researched,
    Fully_Upgraded,
    Currently_Researching,
    Currently_Upgrading,
    Insufficient_Minerals,
    Insufficient_Gas,
    Insufficient_Supply,
    Insufficient_Energy,
    Insufficient_Tech,
    Insufficient_Ammo,
    Insufficient_Space,
    Invalid_Tile_Position,
    Unbuildable_Location,
    Unreachable_Location,
    Out_Of_Range,
    Unable_To_Hit,
    Access_Denied,
    File_Not_Found,
    Invalid_Parameter,
    None,
    Unknown,
    MAX
};

pub const TechTypes = enum(c_int){
    Stim_Packs,
    Lockdown,
    EMP_Shockwave,
    Spider_Mines,
    Scanner_Sweep,
    Tank_Siege_Mode,
    Defensive_Matrix,
    Irradiate,
    Yamato_Gun,
    Cloaking_Field,
    Personnel_Cloaking,
    Burrowing,
    Infestation,
    Spawn_Broodlings,
    Dark_Swarm,
    Plague,
    Consume,
    Ensnare,
    Parasite,
    Psionic_Storm,
    Hallucination,
    Recall,
    Stasis_Field,
    Archon_Warp,
    Restoration,
    Disruption_Web,
    Unused_26,
    Mind_Control,
    Dark_Archon_Meld,
    Feedback,
    Optical_Flare,
    Maelstrom,
    Lurker_Aspect,
    Unused_33,
    Healing,
    None = 44,
    Nuclear_Strike,
    Unknown,
    MAX
};

pub const Orders = enum(c_int){
    Die,
    Stop,
    Guard,
    PlayerGuard,
    TurretGuard,
    BunkerGuard,
    Move,
    ReaverStop,
    Attack1,
    Attack2,
    AttackUnit,
    AttackFixedRange,
    AttackTile,
    Hover,
    AttackMove,
    InfestedCommandCenter,
    UnusedNothing,
    UnusedPowerup,
    TowerGuard,
    TowerAttack,
    VultureMine,
    StayInRange,
    TurretAttack,
    Nothing,
    Unused_24,
    DroneStartBuild,
    DroneBuild,
    CastInfestation,
    MoveToInfest,
    InfestingCommandCenter,
    PlaceBuilding,
    PlaceProtossBuilding,
    CreateProtossBuilding,
    ConstructingBuilding,
    Repair,
    MoveToRepair,
    PlaceAddon,
    BuildAddon,
    Train,
    RallyPointUnit,
    RallyPointTile,
    ZergBirth,
    ZergUnitMorph,
    ZergBuildingMorph,
    IncompleteBuilding,
    IncompleteMorphing,
    BuildNydusExit,
    EnterNydusCanal,
    IncompleteWarping,
    Follow,
    Carrier,
    ReaverCarrierMove,
    CarrierStop,
    CarrierAttack,
    CarrierMoveToAttack,
    CarrierIgnore2,
    CarrierFight,
    CarrierHoldPosition,
    Reaver,
    ReaverAttack,
    ReaverMoveToAttack,
    ReaverFight,
    ReaverHoldPosition,
    TrainFighter,
    InterceptorAttack,
    ScarabAttack,
    RechargeShieldsUnit,
    RechargeShieldsBattery,
    ShieldBattery,
    InterceptorReturn,
    DroneLand,
    BuildingLand,
    BuildingLiftOff,
    DroneLiftOff,
    LiftingOff,
    ResearchTech,
    Upgrade,
    Larva,
    SpawningLarva,
    Harvest1,
    Harvest2,
    MoveToGas,
    WaitForGas,
    HarvestGas,
    ReturnGas,
    MoveToMinerals,
    WaitForMinerals,
    MiningMinerals,
    Harvest3,
    Harvest4,
    ReturnMinerals,
    Interrupted,
    EnterTransport,
    PickupIdle,
    PickupTransport,
    PickupBunker,
    Pickup4,
    PowerupIdle,
    Sieging,
    Unsieging,
    WatchTarget,
    InitCreepGrowth,
    SpreadCreep,
    StoppingCreepGrowth,
    GuardianAspect,
    ArchonWarp,
    CompletingArchonSummon,
    HoldPosition,
    QueenHoldPosition,
    Cloak,
    Decloak,
    Unload,
    MoveUnload,
    FireYamatoGun,
    MoveToFireYamatoGun,
    CastLockdown,
    Burrowing,
    Burrowed,
    Unburrowing,
    CastDarkSwarm,
    CastParasite,
    CastSpawnBroodlings,
    CastEMPShockwave,
    NukeWait,
    NukeTrain,
    NukeLaunch,
    NukePaint,
    NukeUnit,
    CastNuclearStrike,
    NukeTrack,
    InitializeArbiter,
    CloakNearbyUnits,
    PlaceMine,
    RightClickAction,
    SuicideUnit,
    SuicideLocation,
    SuicideHoldPosition,
    CastRecall,
    Teleport,
    CastScannerSweep,
    Scanner,
    CastDefensiveMatrix,
    CastPsionicStorm,
    CastIrradiate,
    CastPlague,
    CastConsume,
    CastEnsnare,
    CastStasisField,
    CastHallucination,
    Hallucination2,
    ResetCollision,
    ResetHarvestCollision,
    Patrol,
    CTFCOPInit,
    CTFCOPStarted,
    CTFCOP2,
    ComputerAI,
    AtkMoveEP,
    HarassMove,
    AIPatrol,
    GuardPost,
    RescuePassive,
    Neutral,
    ComputerReturn,
    InitializePsiProvider,
    SelfDestructing,
    Critter,
    HiddenGun,
    OpenDoor,
    CloseDoor,
    HideTrap,
    RevealTrap,
    EnableDoodad,
    DisableDoodad,
    WarpIn,
    Medic,
    MedicHeal,
    HealMove,
    MedicHoldPosition,
    MedicHealToIdle,
    CastRestoration,
    CastDisruptionWeb,
    CastMindControl,
    DarkArchonMeld,
    CastFeedback,
    CastOpticalFlare,
    CastMaelstrom,
    JunkYardDog,
    Fatal,
    None,
    Unknown,
    MAX
};

pub const UnitCommandType = enum(c_int){
    Attack_Move = 0,
    Attack_Unit,
    Build,
    Build_Addon,
    Train,
    Morph,
    Research,
    Upgrade,
    Set_Rally_Position,
    Set_Rally_Unit,
    Move,
    Patrol,
    Hold_Position,
    Stop,
    Follow,
    Gather,
    Return_Cargo,
    Repair,
    Burrow,
    Unburrow,
    Cloak,
    Decloak,
    Siege,
    Unsiege,
    Lift,
    Land,
    Load,
    Unload,
    Unload_All,
    Unload_All_Position,
    Right_Click_Position,
    Right_Click_Unit,
    Halt_Construction,
    Cancel_Construction,
    Cancel_Addon,
    Cancel_Train,
    Cancel_Train_Slot,
    Cancel_Morph,
    Cancel_Research,
    Cancel_Upgrade,
    Use_Tech,
    Use_Tech_Position,
    Use_Tech_Unit,
    Place_COP,
    None,
    Unknown,
    MAX
};

pub const UpgradeTypes = enum(c_int){
    Terran_Infantry_Armor = 0,
    Terran_Vehicle_Plating = 1,
    Terran_Ship_Plating = 2,
    Zerg_Carapace = 3,
    Zerg_Flyer_Carapace = 4,
    Protoss_Ground_Armor = 5,
    Protoss_Air_Armor = 6,
    Terran_Infantry_Weapons = 7,
    Terran_Vehicle_Weapons = 8,
    Terran_Ship_Weapons = 9,
    Zerg_Melee_Attacks = 10,
    Zerg_Missile_Attacks = 11,
    Zerg_Flyer_Attacks = 12,
    Protoss_Ground_Weapons = 13,
    Protoss_Air_Weapons = 14,
    Protoss_Plasma_Shields = 15,
    U_238_Shells = 16,
    Ion_Thrusters = 17,
    Titan_Reactor = 19,
    Ocular_Implants = 20,
    Moebius_Reactor = 21,
    Apollo_Reactor = 22,
    Colossus_Reactor = 23,
    Ventral_Sacs = 24,
    Antennae = 25,
    Pneumatized_Carapace = 26,
    Metabolic_Boost = 27,
    Adrenal_Glands = 28,
    Muscular_Augments = 29,
    Grooved_Spines = 30,
    Gamete_Meiosis = 31,
    Metasynaptic_Node = 32,
    Singularity_Charge = 33,
    Leg_Enhancements = 34,
    Scarab_Damage = 35,
    Reaver_Capacity = 36,
    Gravitic_Drive = 37,
    Sensor_Array = 38,
    Gravitic_Boosters = 39,
    Khaydarin_Amulet = 40,
    Apial_Sensors = 41,
    Gravitic_Thrusters = 42,
    Carrier_Capacity = 43,
    Khaydarin_Core = 44,
    Argus_Jewel = 47,
    Argus_Talisman = 49,
    Caduceus_Reactor = 51,
    Chitinous_Plating = 52,
    Anabolic_Synthesis = 53,
    Charon_Boosters = 54,
    Upgrade_60 = 60,
    None = 61,
    Unknown,
    MAX
};


pub const WhatBuilds = [@intFromEnum(UnitType.MAX)]UnitType {
    UnitType.Terran_Barracks, UnitType.Terran_Barracks, UnitType.Terran_Factory, UnitType.Terran_Factory, UnitType.None, UnitType.Terran_Factory, UnitType.None, UnitType.Terran_Command_Center, UnitType.Terran_Starport,
    UnitType.Terran_Starport, UnitType.None, UnitType.Terran_Starport, UnitType.Terran_Starport, UnitType.None, UnitType.Terran_Nuclear_Silo, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None,
    UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.Terran_Factory, UnitType.None, UnitType.Terran_Barracks, UnitType.None, UnitType.Terran_Barracks, UnitType.Zerg_Hatchery, UnitType.Zerg_Larva,
    UnitType.Zerg_Larva, UnitType.Zerg_Larva, UnitType.Zerg_Larva, UnitType.None, UnitType.Zerg_Larva, UnitType.Zerg_Larva, UnitType.Zerg_Larva, UnitType.Zerg_Mutalisk, UnitType.Zerg_Larva, UnitType.Zerg_Larva, UnitType.Zerg_Larva,
    UnitType.None, UnitType.None, UnitType.Zerg_Infested_Command_Center, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.Terran_Starport, UnitType.Zerg_Mutalisk, UnitType.Protoss_Stargate,
    UnitType.Protoss_Gateway, UnitType.Zerg_Mutalisk, UnitType.Protoss_Dark_Templar, UnitType.Protoss_Nexus, UnitType.Protoss_Gateway, UnitType.Protoss_Gateway, UnitType.Protoss_Gateway,
    UnitType.Protoss_High_Templar, UnitType.Protoss_Robotics_Facility, UnitType.Protoss_Stargate, UnitType.Protoss_Stargate, UnitType.Protoss_Stargate, UnitType.Protoss_Carrier, UnitType.None, UnitType.None,
    UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.Protoss_Robotics_Facility, UnitType.Protoss_Robotics_Facility, UnitType.Protoss_Reaver, UnitType.None, UnitType.None, UnitType.None,
    UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.Zerg_Hydralisk, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.Zerg_Hydralisk, UnitType.None, UnitType.None, UnitType.Terran_SCV,
    UnitType.Terran_Command_Center, UnitType.Terran_Command_Center, UnitType.Terran_SCV, UnitType.Terran_SCV, UnitType.Terran_SCV, UnitType.Terran_SCV, UnitType.Terran_SCV, UnitType.Terran_SCV, UnitType.Terran_Starport,
    UnitType.Terran_SCV, UnitType.Terran_Science_Facility, UnitType.Terran_Science_Facility, UnitType.None, UnitType.Terran_Factory, UnitType.None, UnitType.Terran_SCV, UnitType.Terran_SCV, UnitType.Terran_SCV,
    UnitType.Terran_SCV, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.Zerg_Drone, UnitType.Zerg_Hatchery, UnitType.Zerg_Lair, UnitType.Zerg_Drone, UnitType.Zerg_Drone, UnitType.Zerg_Drone, UnitType.Zerg_Spire,
    UnitType.Zerg_Drone, UnitType.Zerg_Drone, UnitType.Zerg_Drone, UnitType.Zerg_Drone, UnitType.Zerg_Drone, UnitType.Zerg_Drone, UnitType.Zerg_Creep_Colony, UnitType.None, UnitType.Zerg_Creep_Colony, UnitType.None, UnitType.None,
    UnitType.Zerg_Drone, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.Protoss_Probe, UnitType.Protoss_Probe, UnitType.Protoss_Probe, UnitType.Protoss_Probe, UnitType.None, UnitType.Protoss_Probe, UnitType.Protoss_Probe,
    UnitType.None, UnitType.Protoss_Probe, UnitType.Protoss_Probe, UnitType.Protoss_Probe, UnitType.Protoss_Probe, UnitType.Protoss_Probe, UnitType.Protoss_Probe, UnitType.None, UnitType.Protoss_Probe, UnitType.Protoss_Probe,
    UnitType.Protoss_Probe, UnitType.Protoss_Probe, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None,
    UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None,
    UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.None, UnitType.Unknown
};