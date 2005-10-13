#!/bin/sh

echo '1..2'

perl $srcdir/test.pl 2> /dev/null > test.pl.out
perlstatus=$?

# Test:;More prints diagnostic from TODO tests on stdout
# http://rt.cpan.org/Ticket/Display.html?id=14982
sed '/^#/D' test.pl.out > tmp
mv tmp test.pl.out

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
	retval=1
	echo 'not ok 2 - status code'
	echo "# perlstatus = $perlstatus"
	echo "#    cstatus = $cstatus"
fi

exit $retval
