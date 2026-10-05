#pragma once
/* Directives are the bot's scripted build order, read from a text file.
 *
 * Line format:
 *   (UNIT_QTY/SUPPLY/TIMESTAMP/AI_FLAG) QTY VALUE : (COMMAND) QTY UNIT_TYPE LOCATION
 * Examples:
 *   SUPPLY 12 X : BUILD 1 Zerg_Spawning_Pool MAIN
 *   UNIT_QTY 8 Zerg_Mutalisk : FORM_ARMY 8 Zerg_Mutalisk ANYWHERE
 * VALUE is ignored for SUPPLY and TIMESTAMP. Lines starting with # are comments. */

#include <stddef.h>
#include <stdint.h>

#include "bwenums.h"

#define MACRO_COMMAND_LIST(X) X(BUILD) X(TRAIN) X(SCOUT) X(EXPAND) X(FORM_ARMY)
#define PREREQ_TYPE_LIST(X)   X(UNIT_QTY) X(TIMESTAMP) X(AI_FLAG) X(SUPPLY)
#define TARGET_LOC_LIST(X)    X(MAIN) X(NATURAL) X(NEXT_VALID_EXP) X(LAST_SUCCESSFUL_EXP) \
                              X(ENEMY_MAIN) X(NEAREST_ENEMY_BASE) X(ANYWHERE)

typedef enum MacroCommandType {
#define X(n) CMD_##n,
    MACRO_COMMAND_LIST(X)
#undef X
    CMD_COUNT
} MacroCommandType;

typedef enum PrereqType {
#define X(n) PREREQ_##n,
    PREREQ_TYPE_LIST(X)
#undef X
    PREREQ_COUNT
} PrereqType;

typedef enum TargetLocation {
#define X(n) LOC_##n,
    TARGET_LOC_LIST(X)
#undef X
    LOC_COUNT
} TargetLocation;

typedef enum DirectiveStatus { STATUS_INACTIVE, STATUS_IN_PROGRESS, STATUS_DONE } DirectiveStatus;

typedef struct Prerequisite {
    PrereqType type;
    uint8_t    qty;    /* units required, seconds elapsed, or supply count */
    int        value;  /* unit type id for UNIT_QTY, flag value for AI_FLAG (negative) */
} Prerequisite;

typedef struct Command {
    MacroCommandType type;
    UnitTypeId       target_type;
    uint8_t          target_qty;
    TargetLocation   target_loc;
} Command;

typedef struct Directive {
    Prerequisite    prereq;
    Command         command;
    DirectiveStatus status;
} Directive;

typedef enum ParseError {
    PARSE_OK = 0,
    PARSE_INVALID_PREREQ_TYPE,
    PARSE_INVALID_COMMAND_TYPE,
    PARSE_INVALID_LOCATION,
    PARSE_INVALID_UNIT_TYPE,
    PARSE_INVALID_FORMAT,
    PARSE_INVALID_NUMBER,
    PARSE_FILE_NOT_FOUND,
    PARSE_OUT_OF_MEMORY,
} ParseError;

const char* parse_error_name(ParseError err);

/* Parses one trimmed, non-comment line. */
ParseError parse_directive_line(const char* line, Directive* out);

/* Reads the whole file. On success *out is a malloc'd array of *count directives
 * that the caller frees. Stops at the first bad line and reports it. */
ParseError parse_directive_file(const char* path, Directive** out, size_t* count);

/* Name lookups (return -1 when not found). */
int unit_type_from_name(const char* name);
