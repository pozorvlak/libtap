#!/usr/bin/perl

use warnings;
use strict;

use Test::More;

plan tests => 4;

ok(1 == 1, '1 equals 1');	# Test ok() passes when it should
ok(1 == 1, '1 == 1');		# Test ok1() passes when it should
ok(1 == 2, '1 equals 2');	# Test ok() fails when it should
ok(1 == 2, '1 == 2');		# Test ok1() fails when it should
