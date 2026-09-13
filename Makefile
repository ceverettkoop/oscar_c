# oscar: BWAPI 4.2 Brood War bot in C, built on the BWAPI-C wrapper.
#
#   make            -> build/oscar.dll      32-bit Windows DLL (cross-compiled with MinGW)
#   make native     -> build/liboscar.so    shared library for OpenBW on the host (.dylib on macOS)
#   make DEBUG=1    -> -O0 -g instead of -O2 -g
#   make clean

CROSS_CC  ?= i686-w64-mingw32-gcc
NATIVE_CC ?= cc
DEBUG     ?= 0

SRC      := $(wildcard src/*.c)
BUILD    := build
WIN_OBJ  := $(patsubst src/%.c,$(BUILD)/win/%.o,$(SRC))
NAT_OBJ  := $(patsubst src/%.c,$(BUILD)/native/%.o,$(SRC))

CFLAGS   := -std=c11 -Wall -Wextra -Iinclude -MMD -MP -g
ifeq ($(DEBUG),1)
CFLAGS   += -O0
else
CFLAGS   += -O2
endif

# The MSVC-produced import library links directly: BWAPI-C is plain cdecl.
WIN_LDFLAGS := -shared -static-libgcc
WIN_LDLIBS  := lib/BWAPIC.lib

ifeq ($(shell uname -s),Darwin)
NATIVE_LIB := $(BUILD)/liboscar.dylib
else
NATIVE_LIB := $(BUILD)/liboscar.so
endif
NAT_LDFLAGS := -shared -fPIC -Llib
NAT_LDLIBS  := -lBWAPILIB -lBWAPIC

.PHONY: all windows native clean
all: windows
windows: $(BUILD)/oscar.dll
native: $(NATIVE_LIB)

$(BUILD)/oscar.dll: $(WIN_OBJ)
	$(CROSS_CC) $(WIN_LDFLAGS) -o $@ $^ $(WIN_LDLIBS)

$(NATIVE_LIB): $(NAT_OBJ)
	$(NATIVE_CC) $(NAT_LDFLAGS) -o $@ $^ $(NAT_LDLIBS)

$(BUILD)/win/%.o: src/%.c | $(BUILD)/win
	$(CROSS_CC) $(CFLAGS) -c -o $@ $<

$(BUILD)/native/%.o: src/%.c | $(BUILD)/native
	$(NATIVE_CC) $(CFLAGS) -fPIC -c -o $@ $<

$(BUILD)/win $(BUILD)/native:
	mkdir -p $@

clean:
	rm -rf $(BUILD)

-include $(WIN_OBJ:.o=.d) $(NAT_OBJ:.o=.d)
