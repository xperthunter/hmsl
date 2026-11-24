#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/framework.sh"

HMSL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

source "${HMSL_ROOT}/lib/score.sh"

export HMSL_LAB="lab_test"

setup_test_home

mkdir -p "$HOME/.hmsl/history"

cat > "$HOME/.hmsl/history/lab_test.history" << EOF
date
ls
ls -la
EOF

test_history_contains_date()
{
	if history_contains "^date$"; then
		pass "history_contains finds date"
	else
		fail "history_contains finds date"
	fi
}
test_history_contains_date

test_history_contains_missing()
{
	if history_contains "^pwd$"; then
		fail "history_contains rejects missing command"
	else
		pass "history_contains rejects missing command"
	fi
}
test_history_contains_missing

test_history_contains_regex()
{
	if history_contains "^ls.*$"; then
		pass "history_contains supports regex"
	else
		fail "history_contains supports regex"
	fi
}
test_history_contains_regex

test_require_command_pass()
{
	score=0
	possible=0

	require_command 1 "ran date" date >/dev/null 2>&1

	assert_equals \
		"1" \
		"$score" \
		"require_command awards points"
	
	assert_equals \
		"1" \
		"$possible" \
		"require_command updates possible points"
}
test_require_command_pass

test_require_command_fail()
{
	score=0
	possible=0

	require_command 1 "ran pwd" "pwd" >/dev/null 2>&1

	assert_equals "0" "$score" "require_command gives no points"

	assert_equals "1" "$possible" "require_command still increments possible"
}
test_require_command_fail

# helper functions
always_pass()
{
	return 0
}

always_fail()
{
	return 1
}

test_check_pass()
{
	score=0
	possible=0

	check 2 "pass test" always_pass >/dev/null 2>&1

	assert_equals "2" "$score" "check adds score"
	assert_equals "2" "$possible" "check adds possible"
}
test_check_pass

test_check_fail()
{
	score=0
	possible=0

	check 2 "fail test" always_fail >/dev/null 2>&1

	assert_equals "0" "$score" "check does not add score on failed check"
	assert_equals "2" "$possible" "check adds possible"
}
test_check_fail

test_summary_output()
{
	score=3
	possible=5

	output="$(summary)"

	assert_contains \
		"$output" \
		"Score : 3/5" \
		"summary displays score"
}
test_summary_output

cleanup_test_home

test_summary 
