
TESTS = 		test.t
TESTS_ENVIRONMENT =	$(SHELL)

EXTRA_DIST = 		$(TESTS) test.pl

check_PROGRAMS = 	test

test_CFLAGS = 		-g -I$(top_srcdir)/src
test_LDFLAGS = 		-L$(top_builddir)/src
test_LDADD = 		-ltap

CLEANFILES =	test.o test.c.out test.pl.out
