LIB=		tap

SRCS=		tap.c

NOMAN=		noman

CFLAGS+=	-g

SUBDIR+=	t

test: all
	prove -r -v

.include <bsd.lib.mk>
