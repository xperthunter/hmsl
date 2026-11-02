#!/usr/bin/env bash

HMSL_BIN="../bin/hmsl"

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

# Test 1: No arguments
output="$("$HMSL_BIN" 2>&1)"
status=$?

assert_exit_code 1 "$status" "No arguments returns exit code 1"

# Test 2: Help command
output="$("$HMSL_BIN" help 2>&1)"
status=$?

assert_exit_code 0 "$status" "Help returns exit code 0"

assert_contains "$output" "Usage:" "Help displays usage"

# Test 3: -h switch
output="$("$HMSL_BIN" -h 2>&1)"
status=$?

assert_exit_code 0 "$status" "-h returns exit code 0"

assert_contains "$output" "Usage:" "-h displays usage"

# Test 4: Unknown command
output="$("$HMSL_BIN" pizza 2>&1)"
status=$?

assert_exit_code 1 "$status" "Unknown command returns exit code 1"

assert_contains "$output" "Unknown command" "Unknown command message displayed"


# Test 5: Missing lab name
output="$("$HMSL_BIN" score 2>&1)"
status=$?

assert_exit_code 1 "$status" "Missing lab returns exit code 1"

# Test 6: Unknown lab
output="$("$HMSL_BIN" score lab999 2>&1)"
status=$?

assert_exit_code 1 "$status" "Unknown lab returns exit code 1"

assert_contains "$output" "Unknown lab" "Unknown lab message displayed"

# Test 7: Existing lab
output="$("$HMSL_BIN" score lab01 2>&1)"
status=$?

assert_exit_code 0 "$status" "Existing lab laods successfully"

echo
echo "==================="
echo " HMSL TEST SUMMARY "
echo "==================="

if [[ "$FAIL_COUNT" -eq 0 ]]; then
	printf "${GREEN}✓ All tests passed (%d)\n${NC}" "$PASS_COUNT"
else
	printf "${RED}✗ %d tests failed\n${NC}" "$FAIL_COUNT"
fi


