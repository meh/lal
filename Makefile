NAME    = lal
VERSION = 0.0.1

LIB_NAME = "lib${NAME}.so"

CC         = gcc
CFLAGS     = -D___VERSION___="\"${VERSION}\"" $(shell nspr-config --cflags) -I./src/
LDFLAGS    = $(shell nspr-config --libs)

ifdef DEBUG
CFLAGS += -g3 -DWORKING -Wall
endif

ifdef DDEBUG
CFLAGS += -DDEBUG -g3 -Wall
endif

INST_LIBDIR     = /usr/lib
INST_HEADERSDIR = /usr/include/lal

DIR     = src
FILES   = 
HEADERS = 

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
	chmod -R a+r ${INST_HEADERSDIR}

uninstall:
	rm -f ${INST_LIBDIR}/${LIB_NAME}
	rm -f ${INST_HEADERSDIR}
	
clean:
	rm -f ${LIB_NAME}
	find src | egrep "\.l?o" | xargs rm -f

