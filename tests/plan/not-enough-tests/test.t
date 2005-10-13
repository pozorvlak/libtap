#!/bin/sh

echo '1..2'

perl $srcdir/test.pl 2> /dev/null > test.pl.out
perlstatus=$?

./test 2> /dev/null > test.c.out
cstatus=$?

diff -u test.pl.out test.c.out

if [ $? -eq 0 ]; then
	echo 'ok 1 - output is identical'
else
	retval=1
	echo 'not ok 1 - output is identical'
fi

if [ $perlstatus -eq $cstatus ]; then
	echo 'ok 2 - status code'
else
	# comment this out until we're exit-code compatible with Test::More
	#retval=1
	echo 'not ok 2 - status code'
	echo "# perlstatus = $perlstatus"
	echo "#    cstatus = $cstatus"
fi

exit $retval
