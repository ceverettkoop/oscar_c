BWAPI 4.2 Brood War DLL bot written in C using the BWAPI-C wrapper.

## Building

Requires GNU make and a MinGW cross compiler (`i686-w64-mingw32-gcc`, package
`mingw-w64-gcc` on Arch, `gcc-mingw-w64-i686` on Debian/Ubuntu, `mingw-w64` via brew).

```
make
```

produces `build/oscar.dll`, a 32-bit Windows DLL compatible with StarCraft 1.16.1 and
the BWAPI.dll in `lib`. Put the included `BWAPIC.dll` next to `StarCraft.exe` and set
`ai = ../build/oscar.dll` (or wherever you copy it) in `bwapi-data/bwapi.ini`.

`make DEBUG=1` builds with `-O0`. Debug info is DWARF, usable with gdb/lldb under Wine.

### OpenBW (Linux/macOS)

Build openbw and bwapi-c from source:

```
https://github.com/OpenBW/bwapi
https://github.com/RnDome/bwapi-c
```

place `libBWAPILIB` and `libBWAPIC` in `lib` and run:

```
make native
```

which builds `build/liboscar.so` (`.dylib` on macOS) for BWAPILauncher. See `.env` /
`.mac.env` for the environment BWAPILauncher needs.

## Layout

- `src/bwapi_module.c` exports `gameInit` / `newAIModule` and the AIModule vtable
- `src/oscar.c` per-frame bot logic
- `src/gamestate.c` unit table and directive tracking
- `src/directive.c` build-order script parser (`script/test_directives`)
- `src/bwenums.c`, `include/bwenums.h` BWAPI id tables (generated from the old Zig enums)
- `src/util.c` growable array, int hash map, logging
- `zig_legacy/` the original Zig implementation, kept for reference
