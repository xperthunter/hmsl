#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/framework.sh"

HMSL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

HMSL_BIN="${HMSL_ROOT}/bin/hmsl"

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

test_summary 

