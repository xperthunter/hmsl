#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/framework.sh"

HMSL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

HMSL="$HMSL_ROOT"

source "${HMSL_ROOT}/lib/reset.sh"

test_reset_history_creates_file()
{
	setup_test_home

	mkdir -p "$HOME/.hmsl/history"

	reset_history "lab01"

	if [[ -f "$HOME/.hmsl/history/lab01.history" ]]; then
		pass "reset_history creates history file"
	else
		fail "reset_history creates history file"
	fi
	
	cleanup_test_home
}
test_reset_history_creates_file

test_reset_history_clears_file()
{
	setup_test_home

	mkdir -p "$HOME/.hmsl/history"

	cat > "$HOME/.hmsl/history/lab01.history" <<-EOF
		date
		ls
		pwd
	EOF

	reset_history "lab01"

	if [[ ! -s "$HOME/.hmsl/history/lab01.history" ]]; then
		pass "reset_history clears history file"
	else
		fail "reset_history clears history file"
	fi
	
	cleanup_test_home
}
test_reset_history_clears_file

test_reset_lab_message()
{
	output="$(reset_lab lab01)"

	assert_contains \
		"$output" \
		"lab01 reset successfully" \
		"reset_lab prints success message"
}
test_reset_lab_message

test_summary
