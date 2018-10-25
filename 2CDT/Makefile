# Makefile for 2cdt utility

.PHONY: clean
CC = gcc
BIND = gcc
RM = rm

#   CFLAGS    flags for C compile
#   LFLAGS1   flags after output file spec, before obj file list
#   LFLAGS2   flags after obj file list (libraries, etc)

CFLAGS = -O2 -O3 -DUNIX
LFLAGS1 =
LFLAGS2 = -s 

CDT_O=	src/2cdt.o src/tzxfile.o

2cdt:	$(CDT_O) 
	$(BIND)  $(CDT_O) -o 2cdt $(LFLAGS1) $(LFLAGS2) $(LIBS)

clean:
	rm -rf src/*.o
	rm -f 2cdt
	rm -f 2cdt.exe
