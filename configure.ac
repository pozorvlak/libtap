#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.59)
AC_INIT(FULL-PACKAGE-NAME, VERSION, BUG-REPORT-ADDRESS)
AC_CONFIG_SRCDIR([src/tap.c])
AC_CONFIG_HEADER([config.h])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.
# FIXME: Replace `main' with a function in `-lpthread':
AC_CHECK_LIB([pthread], [main])
# FIXME: Replace `main' with a function in `-ltap':
AC_CHECK_LIB([tap], [main])

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([stdlib.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST

# Checks for library functions.
AC_FUNC_VPRINTF
AC_CHECK_FUNCS([atexit])

AC_CONFIG_FILES([src/Makefile
                 src/t/Makefile
                 src/t/diag/Makefile
                 src/t/fail/Makefile
                 src/t/ok/Makefile
                 src/t/ok/ok-hash/Makefile
                 src/t/ok/ok-numeric/Makefile
                 src/t/ok/ok/Makefile
                 src/t/pass/Makefile
                 src/t/plan/Makefile
                 src/t/plan/no-tests/Makefile
                 src/t/plan/no_plan/Makefile
                 src/t/plan/not-enough-tests/Makefile
                 src/t/plan/sane/Makefile
                 src/t/plan/skip_all/Makefile
                 src/t/plan/too-many-plans/Makefile
                 src/t/plan/too-many-tests/Makefile
                 src/t/skip/Makefile
                 src/t/todo/Makefile])
AC_OUTPUT
