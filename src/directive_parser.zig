const std = @import("std");

//(UNIT_QTY/SUPPLY/TIMESTAMP/FLAG) X (UNIT_TYPE/TIME/FLAG_VAL) : (COMMAND) X (UNIT_TYPE) (LOCATION)
//EXAMPLE
//(X is ignored when prereq type is not UNIT_QTY)
//SUPPLY 12 X : BUILD 1 Zerg_Spawning_Pool MAIN
//UNIT_QTY 8 Zerg_Mutalisk : FORM_ARMY 8 Zerg_Mutalisk ANYWHERE
//string, u8, c_int : string, u8, string, string