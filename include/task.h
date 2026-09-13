#pragma once

#include "Types.h"
#include "directive.h"

typedef struct Task {
    Unit*       unit;
    UnitCommand unit_command;
    Directive*  origin_directive;
} Task;
