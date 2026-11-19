#!/usr/bin/env bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

PASS_COUNT=0
FAIL_COUNT=0

pass()
{
	printf "${GREEN}[PASS]${NC} %s\n" "$1"
	((PASS_COUNT++))
}

fail()
{
	printf "${RED}[FAIL]${NC} %s\n" "$1"
	((FAIL_COUNT++))
}

assert_exit_code()
{
	local expected="$1"
	local actual="$2"
	local message="$3"

	if [[ "$expected" -eq "$actual" ]]; then
		pass "$message"
	else
		fail "$message (expected $expected got $actual)"
	fi
}

assert_contains()
{
	local haystack="$1"
	local needle="$2"
	local message="$3"

	if grep -q "$needle" <<< "$haystack"; then
		pass "$message"
	else
		fail "$message"
	fi
}

test_summary()
{
	echo
	echo "==================="
	echo " HMSL TEST SUMMARY "
	echo "==================="

	if [[ "$FAIL_COUNT" -eq 0 ]]; then
		printf "${GREEN}✓ All tests passed (%d)\n${NC}" "$PASS_COUNT"
	else
		printf "${RED}✗ %d tests failed\n${NC}" "$FAIL_COUNT"
	fi
}



