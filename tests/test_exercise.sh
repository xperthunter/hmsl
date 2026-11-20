#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/framework.sh"

HMSL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

source "${HMSL_ROOT}/lib/exercise.sh"

test_exercise_setup_sets_lab()
{
	exercise_setup "lab01"

	assert_equals \
		"lab01" \
		"$HMSL_LAB" \
		"exercise_setup sets HMSL_LAB"
}
test_exercise_setup_sets_lab

test_exercise_setup_sets_history_path()
{
	exercise_setup "lab01"

	assert_equals \
		"$HOME/.hmsl/history/lab01.history" \
		"$HMSL_HISTORY" \
		"exercise_setup sets HMSL_HISTORY"
}
test_exercise_setup_sets_history_path

test_exercise_setup_creates_history_dir()
{
	setup_test_home

	exercise_setup "lab01"

	if [[ -d "$HOME/.hmsl/history" ]]; then
		pass "history directory created"
	else
		fail "history directory created"
	fi

	cleanup_test_home
}
test_exercise_setup_creates_history_dir

test_exercise_setup_creates_history_file()
{
	setup_test_home

	exercise_setup "lab01"

	if [[ -f "$HOME/.hmsl/history/lab01.history" ]]; then
		pass "history file created"
	else
		fail "history file created"
	fi

	cleanup_test_home
}
test_exercise_setup_creates_history_file

test_exercise_instructions()
{
	output="$(exercise_instructions lab01)"

	assert_contains \
		"$output" \
		"hmsl reset lab01" \
		"instructions contain reset command"
	
	assert_contains \
		"$output" \
		"hmsl exercise lab01" \
		"instructions contain exercise command"
}
test_exercise_instructions

test_summary
