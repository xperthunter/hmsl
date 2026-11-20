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
	

}


test_summary
