#!/bin/sh

set -x
aclocal19 -I /usr/local/share/aclocal || aclocal || exit 1
# autoheader259 || autoheader || exit 1
libtoolize15 -c -f || libtoolize -c -f || glibtoolize -c -f || exit 1
automake19 -a -c || automake -a -c || exit 1
autoconf259 || autoconf || exit 1
