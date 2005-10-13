#!/bin/sh

echo '1..8'

perl $srcdir/test.pl 2>/dev/null > test.pl.out
perlstatus=$?

./test > test.c.out 2>&1 
cstatus=$?

if grep "^# Returned: 2$" test.c.out >/dev/null ; then
  echo "ok 1 - expected return value";
else
  echo "not ok 1 - expected return value";
  retval=1
fi

if grep "^#     Failed test (.*test.c:main() at line 39)$" test.c.out >/dev/null ; then
  echo "ok 2 - failed expected test";
else
  echo "not ok 2 - failed expected test";
  retval=1
fi

if grep "^# Returned: 0$" test.c.out >/dev/null ; then
  echo "ok 3 - expected return value";
else
  echo "not ok 3 - expected return value";
  retval=1
fi

if grep "^#     Failed test (.*test.c:main() at line 42)$" test.c.out >/dev/null ; then
  echo "ok 4 - failed expected test";
else
  echo "not ok 4 - failed expected test";
  retval=1
fi
  
if grep "^# Returned: 0$" test.c.out >/dev/null ; then
  echo "ok 5 - expected return value";
else
  echo "not ok 5 - expected return value";
  retval=1
fi

if grep "^# Looks like you failed 2 tests of 2.$" test.c.out >/dev/null ; then
  echo "ok 6 - expected return value";
else
  echo "not ok 6 - expected return value";
  retval=1
fi

sed -e '/^#/D' test.c.out > tmp
mv tmp test.c.out

diff -u test.pl.out test.c.out

if [ $? -eq 0 ]; then
	echo 'ok 7 - output is identical'
else
	retval=1
	echo 'not ok 7 - output is identical'
fi

if [ $perlstatus -eq $cstatus ]; then
	echo 'ok 8 - status code'
else
	retval=1
	echo 'not ok 8 - status code'
	echo "# perlstatus = $perlstatus"
	echo "#    cstatus = $cstatus"
fi

exit $retval
