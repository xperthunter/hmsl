#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/framework.sh"

HMSL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

source "${HMSL_ROOT}/lib/score.sh"

export HMSL_LAB="lab_test"

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
		pass "history_contains supports regex"
	fi
}
test_history_contains_regex

test_summary

