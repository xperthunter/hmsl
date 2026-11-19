#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/framework.sh"

HMSL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

source "${HMSL_ROOT}/lib/exercise.sh"


test_exercise_creates_history_dir()
{
	rm -rf "$HOME/.hmsl"

	bash() { return 0; }

	output="$(exercise "lab01")"

	if [[ -d "$HOME/.hmsl/history" ]]; then
		pass "exercise creates history directory"
	else
		fail "exercise creates history directory"
	fi
}
test_exercise_creates_history_dir

test_exercise_creates_history_file()
{
	rm -rf "$HOME/.hmsl"

	bash() { return 0; }

	output="$(exercise "lab01")"

	if [[ -f "$HOME/.hmsl/history/lab01.history" ]]; then
		pass "exercise creates history file"
	else
		fail "exercise creates history file"
	fi
}
test_exercise_creates_history_file

test_exercise_sets_lab()
{
	bash() { return 0; }

	exercise "lab01"
	
	assert_equals \
		"lab01" \
		"$HMSL_LAB" \
		"exercise sets HMSL_LAB"
}
test_exercise_sets_lab



