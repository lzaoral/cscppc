CFLAGS ?= -std=gnu99 -Wall -Wextra -pedantic -O2 -g
LDFLAGS ?= -pthread

.PHONY: all bin clean doc

all: bin doc

bin: csclng cscppc

doc: csclng.1 cscppc.1

csclng: csclng.o cswrap-core.o

cscppc: cscppc.o cswrap-core.o

csclng.o cscppc.o cswrap-core.o: cswrap-core.h

csclng.1: csclng.txt
	a2x -f manpage -v $<

cscppc.1: cscppc.txt
	a2x -f manpage -v $<

clean:
	rm -f cscppc *.o cscppc.1 cscppc.xml
