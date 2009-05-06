NAME    = lal
VERSION = 0.0.1

LIB_NAME = "lib${NAME}-${VERSION}.so"

INST_LIBDIR     = /usr/lib
INST_HEADERSDIR = /usr/include/lal

DIR     = src
FILES   = 
HEADERS = 

CC         = gcc
CXX		   = g++
CFLAGS     = $(shell nspr-config --cflags) $(shell xml2-config --cflags) -I./include/ -DLAL_LIB_PATH=${INST_LIBDIR} -DLAL_DEFAULT_WRAPPER=${DEFAULT_WRAPPER} -D___VERSION___="\"${VERSION}\""
LDFLAGS    = $(shell nspr-config --libs) $(shell xml2-config --libs) -export-dynamic

ifdef DEBUG
CFLAGS += -g3 -DWORKING -Wall
endif

ifdef DDEBUG
CFLAGS += -DDEBUG -g3 -Wall
endif

all: lal

lal: $(FILES)
	${CC} ${LDFLAGS} -dynamiclib -shared -o ${LIB_NAME} ${FILES} -lc

$(FILES): $(FILES:.o=.c)
	${CC} ${CFLAGS} -fPIC -c $*.c -o $*.lo

install: all
	mkdir -p ${INST_LIBDIR}
	mkdir -p ${INST_HEADERSDIR}
###
	chmod a+rx ${INST_LIBDIR}/${LIB_NAME}
	chmod -R a+r ${INST_HEADERSDIR}

uninstall:
	rm -f ${INST_LIBDIR}/${LIB_NAME}
	rm -f ${INST_HEADERSDIR}
	
clean:
	rm -f ${LIB_NAME}
	find src | egrep "\.l?o" | xargs rm -f

