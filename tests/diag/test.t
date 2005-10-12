#!/bin/sh

cd `dirname $0`

echo '1..2'

make 2>&1 > /dev/null

perl ./test.pl 2>&1 | sed -e 's/#     Failed test \(.*\)/#     Failed test ()/' > test.pl.out
perlstatus=$?

./test 2>&1 | sed -e 's/#     Failed test \(.*\)/#     Failed test ()/' > test.c.out
cstatus=$?

if grep "^# A diagnostic message$" test.c.out > /dev/null ; then
    echo "ok 1 - found a diagnostic message"
else
    echo "not ok 1 - found a diagnostic message"
    retval=1
fi

if grep "^# Returned: 0$" test.c.out > /dev/null ; then
    echo "ok 2 - diag() expected return value" 
else
    echo "not ok 2 - diag() expected return value" 
    retval=1
fi

if grep "^#     Failed test (.*test.c:main() at line 43)$" test.c.out > /dev/null ; then
    echo "ok 3 - 'failed test at line' diag" 
else
    echo "not ok 3 - 'failed test at line' diag" 
    retval=1
fi

if grep "^# ok() passed, and shouldn't$" test.c.out > /dev/null ; then
    echo "ok 4 - expected diag"
else
    echo "ok 4 - expected diag"
    retval=1
fi

if grep "^# Looks like you failed 1 test of 2.$" test.c.out > /dev/null ; then
    echo "ok 5 - failed 1 test"
 else
    echo "ok 5 - failed 1 test"
    retval=1
fi

sed -e '/^#/D' test.c.out > tmp
mv tmp test.c.out

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
