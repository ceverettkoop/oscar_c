#include "directive.h"

#include <ctype.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "util.h"

#define X(n) #n,
static const char* const command_names[] = { MACRO_COMMAND_LIST(X) };
static const char* const prereq_names[]  = { PREREQ_TYPE_LIST(X) };
static const char* const location_names[] = { TARGET_LOC_LIST(X) };
#undef X

const char* parse_error_name(ParseError err)
{
    switch (err) {
    case PARSE_OK:                   return "ok";
    case PARSE_INVALID_PREREQ_TYPE:  return "invalid prerequisite type";
    case PARSE_INVALID_COMMAND_TYPE: return "invalid command type";
    case PARSE_INVALID_LOCATION:     return "invalid location";
    case PARSE_INVALID_UNIT_TYPE:    return "invalid unit type";
    case PARSE_INVALID_FORMAT:       return "invalid format";
    case PARSE_INVALID_NUMBER:       return "invalid number";
    case PARSE_FILE_NOT_FOUND:       return "file not found";
    case PARSE_OUT_OF_MEMORY:        return "out of memory";
    }
    return "unknown";
}

static int lookup(const char* const* names, size_t n, const char* s)
{
    for (size_t i = 0; i < n; i++)
        if (strcmp(names[i], s) == 0) return (int)i;
    return -1;
}

int unit_type_from_name(const char* name)
{
    return lookup(UnitTypeNames, UT_MAX + 1, name);
}

/* Returns the next whitespace-delimited token, NUL-terminating it in place,
 * or NULL when the string is exhausted. */
static char* next_token(char** cursor)
{
    char* s = *cursor;
    while (*s == ' ' || *s == '\t') s++;
    if (*s == '\0') return NULL;
    char* start = s;
    while (*s && *s != ' ' && *s != '\t') s++;
    if (*s) *s++ = '\0';
    *cursor = s;
    return start;
}

static char* trim(char* s)
{
    while (isspace((unsigned char)*s)) s++;
    char* end = s + strlen(s);
    while (end > s && isspace((unsigned char)end[-1])) *--end = '\0';
    return s;
}

static int parse_u8(const char* s, uint8_t* out)
{
    char* end;
    errno = 0;
    long v = strtol(s, &end, 10);
    if (errno || *end || v < 0 || v > 255) return -1;
    *out = (uint8_t)v;
    return 0;
}

static int parse_int(const char* s, int* out)
{
    char* end;
    errno = 0;
    long v = strtol(s, &end, 10);
    if (errno || *end || v < INT32_MIN || v > INT32_MAX) return -1;
    *out = (int)v;
    return 0;
}

ParseError parse_directive_line(const char* line, Directive* out)
{
    if (line[0] == '\0' || line[0] == '#') return PARSE_INVALID_FORMAT;

    char buf[512];
    if (strlen(line) >= sizeof buf) return PARSE_INVALID_FORMAT;
    strcpy(buf, line);

    char* colon = strchr(buf, ':');
    if (!colon) return PARSE_INVALID_FORMAT;
    *colon = '\0';
    char* prereq_part = trim(buf);
    char* command_part = trim(colon + 1);

    /* prerequisite: TYPE QTY VALUE */
    const char* prereq_type_str  = next_token(&prereq_part);
    const char* prereq_qty_str   = next_token(&prereq_part);
    const char* prereq_value_str = next_token(&prereq_part);
    if (!prereq_type_str || !prereq_qty_str || !prereq_value_str) return PARSE_INVALID_FORMAT;

    int prereq_type = lookup(prereq_names, PREREQ_COUNT, prereq_type_str);
    if (prereq_type < 0) return PARSE_INVALID_PREREQ_TYPE;
    uint8_t prereq_qty;
    if (parse_u8(prereq_qty_str, &prereq_qty)) return PARSE_INVALID_NUMBER;

    int prereq_value = 0;
    switch ((PrereqType)prereq_type) {
    case PREREQ_UNIT_QTY:
        prereq_value = unit_type_from_name(prereq_value_str);
        if (prereq_value < 0) return PARSE_INVALID_UNIT_TYPE;
        break;
    case PREREQ_SUPPLY:
    case PREREQ_TIMESTAMP:
        prereq_value = 0; /* VALUE column is ignored */
        break;
    case PREREQ_AI_FLAG: /* TODO change this to a coherent enum */
        if (parse_int(prereq_value_str, &prereq_value)) return PARSE_INVALID_NUMBER;
        break;
    default:
        return PARSE_INVALID_PREREQ_TYPE;
    }

    /* command: TYPE QTY UNIT_TYPE LOCATION */
    const char* command_type_str = next_token(&command_part);
    const char* command_qty_str  = next_token(&command_part);
    const char* command_unit_str = next_token(&command_part);
    const char* command_loc_str  = next_token(&command_part);
    if (!command_type_str || !command_qty_str || !command_unit_str || !command_loc_str)
        return PARSE_INVALID_FORMAT;

    int command_type = lookup(command_names, CMD_COUNT, command_type_str);
    if (command_type < 0) return PARSE_INVALID_COMMAND_TYPE;
    uint8_t command_qty;
    if (parse_u8(command_qty_str, &command_qty)) return PARSE_INVALID_NUMBER;
    int target_type = unit_type_from_name(command_unit_str);
    if (target_type < 0) return PARSE_INVALID_UNIT_TYPE;
    int target_loc = lookup(location_names, LOC_COUNT, command_loc_str);
    if (target_loc < 0) return PARSE_INVALID_LOCATION;

    out->prereq.type  = (PrereqType)prereq_type;
    out->prereq.qty   = prereq_qty;
    out->prereq.value = prereq_value;
    out->command.type        = (MacroCommandType)command_type;
    out->command.target_type = (UnitTypeId)target_type;
    out->command.target_qty  = command_qty;
    out->command.target_loc  = (TargetLocation)target_loc;
    out->status = STATUS_INACTIVE;
    return PARSE_OK;
}

ParseError parse_directive_file(const char* path, Directive** out, size_t* count)
{
    *out = NULL;
    *count = 0;

    FILE* f = fopen(path, "r");
    if (!f) return PARSE_FILE_NOT_FOUND;

    VEC(Directive) list = {0};
    char line[512];
    int lineno = 0;
    ParseError err = PARSE_OK;

    while (fgets(line, sizeof line, f)) {
        lineno++;
        char* trimmed = trim(line);
        if (trimmed[0] == '\0' || trimmed[0] == '#') continue;

        Directive d;
        err = parse_directive_line(trimmed, &d);
        if (err != PARSE_OK) {
            LOG("%s:%d: %s: %s\n", path, lineno, parse_error_name(err), trimmed);
            break;
        }
        if (vec_push(&list, d)) { err = PARSE_OUT_OF_MEMORY; break; }
    }
    fclose(f);

    if (err != PARSE_OK) {
        vec_free(&list);
        return err;
    }
    *out = list.items;
    *count = list.len;
    return PARSE_OK;
}
