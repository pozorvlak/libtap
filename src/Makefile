LIB=		tap

SRCS=		tap.c
LDADD=		-lpthread
NOMAN=		noman

CFLAGS+=	-g

SUBDIR+=	t

test: all
	prove -r -v

.include <bsd.lib.mk>
