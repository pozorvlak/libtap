/*-
 * Copyright (c) 2004 Nik Clayton
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#include "tap.h"

static int no_plan = 0;
static int skip_all = 0;
static int have_plan = 0;
static int test_count = 0;	/* Current number of tests that have been run */
static int e_tests = 0;		/* Expected number of tests to run */

static void _expected_tests(int);
static void _tap_init(void);
static void _cleanup(void);

/*
 * Generate a test result.
 *
 * ok -- boolean, indicates whether or not the test passed.
 * test_name -- the name of the test, may be NULL
 * test_comment -- a comment to print afterwards, may be NULL
 */
void
_gen_result(int ok, char *test_name, char *test_comment)
{

	test_count++;

	_tap_init();

	if(!ok)
		printf("not ");

	printf("ok %d", test_count);

	if(test_name != NULL)
		printf(" - %s", test_name);

	if(test_comment != NULL)
		printf(" # %s", test_comment);

	printf("\n");
}

void
_reset(void)
{
	no_plan = 0;
	skip_all = 0;
	have_plan = 0;
	test_count = 0;
	e_tests = 0;
}

/*
 * Initialise the TAP library.  Will only do so once, however many times it's
 * called.
 */
void
_tap_init(void)
{
	static int run_once = 0;

	if(!run_once) {
		atexit(_cleanup);
		run_once = 1;
	}
}

/*
 * Note that there's no plan.
 */
int
plan_no_plan(void)
{

	if(have_plan != 0) {
		return -1;
	}

	have_plan = 1;
	no_plan = 1;

	return 0;
}

/*
 * Note that the plan is to skip all tests
 */
int
plan_skip_all(char *reason)
{

	skip_all = 1;

	printf("1..0");

	if(reason != NULL)
		printf(" # Skip %s", reason);

	printf("\n");

	exit(0);
	return 0;
}

/*
 * Note the number of tests that will be run.
 */
int
plan_tests(int tests)
{

	if(have_plan != 0) {
		return -1;
	}

	have_plan = 1;

	if(tests == 0) {
		fprintf(stderr, "You said to run 0 tests!  You've got to run something.\n");
		fprintf(stderr, "(did you mean 'plan_skip_all();' ? )\n");
	}
		
	_expected_tests(tests);
}

void
_expected_tests(int tests)
{
	printf("1..%d\n", tests);
	printf("# _expected_tests(%d)\n", tests);
	e_tests = tests;
}

/*
 * Cleanup at the end of the run, produce any final output that might be
 * required.
 */
void
_cleanup(void)
{

	/* No plan provided, but now we know how many tests were run, and can
	   print the header at the end */
	if(!skip_all && (no_plan || !have_plan)) {
		printf("1..%d\n", test_count);
	}
}