#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HMSL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

HMSL_BIN="${HMSL_ROOT}/bin/hmsl"

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
test_no_args()
{
	output="$("$HMSL_BIN" 2>&1)"
	status=$?
	
	assert_exit_code 1 "$status" "No arguments returns exit code 1"
}
test_no_args

# Test 2: Help command
test_help()
{
	output="$("$HMSL_BIN" help 2>&1)"
	status=$?
	
	assert_exit_code 0 "$status" "Help returns exit code 0"
	
	assert_contains "$output" "Usage:" "Help displays usage"
}
test_help

# Test 3: -h switch
test_help_switch(){
	output="$("$HMSL_BIN" -h 2>&1)"
	status=$?
	
	assert_exit_code 0 "$status" "-h returns exit code 0"
	
	assert_contains "$output" "Usage:" "-h displays usage"
}
test_help_switch

# Test 4: Unknown sub-command
test_unk_subcmd()
{
	output="$("$HMSL_BIN" pizza 2>&1)"
	status=$?
	
	assert_exit_code 1 "$status" "Unknown command returns exit code 1"
	
	assert_contains "$output" "Unknown command" "Unknown command message displayed"
}
test_unk_subcmd

# Test 5: Missing lab name for score
test_missing_lab_score()
{
	output="$("$HMSL_BIN" score 2>&1)"
	status=$?
	
	assert_exit_code 1 "$status" "Missing lab returns exit code 1 for score"
	
	assert_contains "$output" "Missing lab name." "Missing lab name error display for score"
}
test_missing_lab_score

# Test 6: Missing lab name for exercise
test_missing_lab_exercise()
{
	output="$("$HMSL_BIN" exercise 2>&1)"
	status=$?
	
	assert_exit_code 1 "$status" "Missing lab returns exit code 1 for exercise"
	
	assert_contains "$output" "Missing lab name." "Missing lab name error message for exercise"
}
test_missing_lab_exercise

# Test 7: Unknown lab for score
test_unk_lab_score()
{
	output="$("$HMSL_BIN" score lab999 2>&1)"
	status=$?
	
	assert_exit_code 1 "$status" "Unknown lab returns exit code 1"
	
	assert_contains "$output" "Unknown lab" "Unknown lab message displayed"
}
test_unk_lab_score

# Test 8: Unknown lab for exercise
test_unk_lab_exercise()
{
	output="$("$HMSL_BIN" exercise exercise999 2>&1)"
	status=$?
	
	assert_exit_code 1 "$status" "Unknown lab returns exit code 1"
	
	assert_contains "$output" "Unknown lab" "Unknown lab message displayed for exercise"
}
test_unk_lab_exercise

# Test 9: Existing lab for
test_existing_lab_score()
{
	output="$("$HMSL_BIN" score lab01 2>&1)"
	status=$?
	
	assert_exit_code 0 "$status" "Existing lab loads successfully"
}
test_existing_lab_score

echo
echo "==================="
echo " HMSL TEST SUMMARY "
echo "==================="

if [[ "$FAIL_COUNT" -eq 0 ]]; then
	printf "${GREEN}✓ All tests passed (%d)\n${NC}" "$PASS_COUNT"
else
	printf "${RED}✗ %d tests failed\n${NC}" "$FAIL_COUNT"
fi


