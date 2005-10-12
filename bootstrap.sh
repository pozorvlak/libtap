#!/bin/sh

set -x
aclocal19 -I /usr/local/share/aclocal || exit 1
autoheader259 || exit 1
libtoolize15 -c -f || exit 1
automake19 -a -c || exit 1
autoconf259 || exit 1
