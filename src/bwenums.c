/* Generated from the original bwenums.zig. */
#include "bwenums.h"

#define X(n) #n,
const char* const UnitTypeNames[UT_MAX + 1] = { UNIT_TYPE_LIST(X) };
#undef X

const UnitTypeId WhatBuilds[UT_MAX] = {
    UT_Terran_Barracks, UT_Terran_Barracks, UT_Terran_Factory, UT_Terran_Factory, UT_None, UT_Terran_Factory, UT_None, UT_Terran_Command_Center,
    UT_Terran_Starport, UT_Terran_Starport, UT_None, UT_Terran_Starport, UT_Terran_Starport, UT_None, UT_Terran_Nuclear_Silo, UT_None,
    UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_Terran_Factory, UT_None,
    UT_Terran_Barracks, UT_None, UT_Terran_Barracks, UT_Zerg_Hatchery, UT_Zerg_Larva, UT_Zerg_Larva, UT_Zerg_Larva, UT_Zerg_Larva,
    UT_None, UT_Zerg_Larva, UT_Zerg_Larva, UT_Zerg_Larva, UT_Zerg_Mutalisk, UT_Zerg_Larva, UT_Zerg_Larva, UT_Zerg_Larva,
    UT_None, UT_None, UT_Zerg_Infested_Command_Center, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_None, UT_Terran_Starport, UT_Zerg_Mutalisk, UT_Protoss_Stargate, UT_Protoss_Gateway, UT_Zerg_Mutalisk, UT_Protoss_Dark_Templar,
    UT_Protoss_Nexus, UT_Protoss_Gateway, UT_Protoss_Gateway, UT_Protoss_Gateway, UT_Protoss_High_Templar, UT_Protoss_Robotics_Facility, UT_Protoss_Stargate, UT_Protoss_Stargate,
    UT_Protoss_Stargate, UT_Protoss_Carrier, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_Protoss_Robotics_Facility, UT_Protoss_Robotics_Facility, UT_Protoss_Reaver, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_Zerg_Hydralisk, UT_None, UT_None, UT_None, UT_None, UT_None, UT_Zerg_Hydralisk,
    UT_None, UT_None, UT_Terran_SCV, UT_Terran_Command_Center, UT_Terran_Command_Center, UT_Terran_SCV, UT_Terran_SCV, UT_Terran_SCV,
    UT_Terran_SCV, UT_Terran_SCV, UT_Terran_SCV, UT_Terran_Starport, UT_Terran_SCV, UT_Terran_Science_Facility, UT_Terran_Science_Facility, UT_None,
    UT_Terran_Factory, UT_None, UT_Terran_SCV, UT_Terran_SCV, UT_Terran_SCV, UT_Terran_SCV, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_Zerg_Drone, UT_Zerg_Hatchery, UT_Zerg_Lair, UT_Zerg_Drone, UT_Zerg_Drone,
    UT_Zerg_Drone, UT_Zerg_Spire, UT_Zerg_Drone, UT_Zerg_Drone, UT_Zerg_Drone, UT_Zerg_Drone, UT_Zerg_Drone, UT_Zerg_Drone,
    UT_Zerg_Creep_Colony, UT_None, UT_Zerg_Creep_Colony, UT_None, UT_None, UT_Zerg_Drone, UT_None, UT_None,
    UT_None, UT_None, UT_Protoss_Probe, UT_Protoss_Probe, UT_Protoss_Probe, UT_Protoss_Probe, UT_None, UT_Protoss_Probe,
    UT_Protoss_Probe, UT_None, UT_Protoss_Probe, UT_Protoss_Probe, UT_Protoss_Probe, UT_Protoss_Probe, UT_Protoss_Probe, UT_Protoss_Probe,
    UT_None, UT_Protoss_Probe, UT_Protoss_Probe, UT_Protoss_Probe, UT_Protoss_Probe, UT_None, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None, UT_None,
    UT_None, UT_Unknown,
};
