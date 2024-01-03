BWAPI 4.2 broodwar DLL bot written in Zig using the BWAPI-C wrapper.
```
zig build -Dwindows=true
```
will cross compile a 1.16.1 compatibile DLL bot that will work with the BWAPI.dll included in lib. You will also need to put the included BWAPIC.dll in the same directory as the starcraft.exe and modify your bwapi-ini file as usual.\
\
for other platforms (using openbw), you will probably have to build openbw and bwapi-c from source
```
https://github.com/OpenBW/bwapi
https://github.com/RnDome/bwapi-c
```
place libBWAPILIB and libBWAPIC in lib and run:
```
zig build
```
this should build a shared library bot compatible with OpenBW. You may have to mess with environmental variables to get it to link properly when you run BWAPILauncher.
