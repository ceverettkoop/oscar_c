CC=i686-w64-mingw32-gcc 
CXX=i686-w64-mingw32-g++

CFLAGS=-I$(IDIR) -mabi=ms -ggdb
CPPFLAGS=-I$(IDIR)

ODIR=obj
IDIR =../include
LDFLAGS=-L../lib
LDLIBS=-lBWAPIC

DEPDIR := .deps
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.d
_DEPS=
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ=main.o

OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

BINNAME=Oscar_c_d.dll

#$(LDFLAGS) $(LDLIBS)
$(ODIR)/%.o: %.c $(DEPS)
	$(CC) -c -o$@ $< $(CFLAGS)

mybot:$(OBJ)
	$(CC) -shared -o../bin/$(BINNAME) $(OBJ) $(CFLAGS) $(LDFLAGS) $(LDLIBS)

$(DEPDIR): ; @mkdir -p $@

DEPFILES := $(SRCS:%.cpp=$(DEPDIR)/%.d)
$(DEPFILES):

include $(wildcard $(DEPFILES))

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o

install:
	cp ../bin/$(BINNAME) ../starcraft/bwapi-data/