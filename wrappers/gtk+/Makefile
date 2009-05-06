NAME    = lal
VERSION = 0.0.1

LIB_NAME = "lib${NAME}.so"

CC         = gcc
CXX		   = g++
CFLAGS     = -D___VERSION___="\"${VERSION}\"" $(shell nspr-config --cflags) $(shell pkg-config --cflags gtk+-2.0) -I./src/
LDFLAGS    = $(shell nspr-config --libs) $(shell pkg-config --libs gtk+-2.0) -export-dynamic

ifdef DEBUG
CFLAGS += -g3 -DWORKING -Wall
endif

ifdef DDEBUG
CFLAGS += -DDEBUG -g3 -Wall
endif

INST_LIBDIR     = /usr/lib

DIR     = src
FILES   = 

all: lal

lal: $(FILES)
	${CC} ${LDFLAGS} -dynamiclib -shared -o ${FILES} ${LIB_NAME} -lc

$(FILES): $(FILES:.o=.c)
	${CC} ${CFLAGS} -fPIC -c $*.c -o $*.lo

install: all
	mkdir -p ${INST_LIBDIR}
	mkdir -p ${INST_HEADERSDIR}
###
	chmod a+rx ${INST_LIBDIR}/${LIB_NAME}

uninstall:
	rm -f ${INST_LIBDIR}/${LIB_NAME}
	
clean:
	rm -f ${LIB_NAME}
	find src | egrep "\.l?o" | xargs rm -f

