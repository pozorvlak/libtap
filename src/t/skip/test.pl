#!/usr/bin/perl

use warnings;
use strict;

use Test::More;

plan tests => 4;

my $side_effect = 0;		# Check whether skipping has side effects

ok(1 == 1, '1 equals 1');	# Test ok() passes when it should

# Start skipping
SKIP: {
	skip "Testing skipping", 1;

	$side_effect++;

	ok($side_effect == 1, '$side_effect checked out');
}

SKIP: {
	skip "Testing skipping #2", 1;

	$side_effect++;

	ok($side_effect == 1, '$side_effect checked out');
}

ok($side_effect == 0, "side_effect is $side_effect");

