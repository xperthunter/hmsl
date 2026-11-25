#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/framework.sh"

HMSL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

test_help_outputs_objectives()
{
	setup_test_home

	export HMSL="$(mktemp -d)"
	export HMSL_LAB="testlab"

	mkdir -p "$HMSL/labs/testlab"

	cat > "$HMSL/labs/testlab/objectives.txt" <<-EOF
	Objective 1
	Objective 2
	EOF

	output="$(
		source "${HMSL_ROOT}/lib/exercise.bashrc" >/dev/null
		help
	)"

	assert_contains \
		"$output" \
		"Objective 1" \
		"help displays objectives"
	
	cleanup_test_home
}
test_help_outputs_objectives

test_score_extracts_points()
{
	setup_test_home

	export HMSL="$(mktemp -d)"
	export HMSL_LAB="testlab"
	export HMSL_HISTORY="$HOME/.hmsl/history/testlab.history"

	mkdir -p "$HMSL/labs/testlab"
	mkdir -p "$HOME/.hmsl/history"

	cat > "$HMSL/labs/testlab/objectives.txt" <<-EOF
		Test Objective
	EOF

	hmsl()
	{
		echo "Score : 3/5"
	}

	output="$(
		source "${HMSL_ROOT}/lib/exercise.bashrc" >/dev/null 2>&1
		score
		echo "${HMSL_SCORE}:${HMSL_POSSIBLE}"
	)"

	assert_contains \
		"$output" \
		"3:5" \
		"score extracts points from hmsl output"
	
	unset -f hmsl

	rm -rf "$HMSL"

	cleanup_test_home
}
test_score_extracts_points

test_score_complete_message()
{
	setup_test_home

	export HMSL="$(mktemp -d)"
	export HMSL_LAB="testlab"
	export HMSL_HISTORY="$HOME/.hmsl/history/testlab.history"

	mkdir -p "$HMSL/labs/testlab"
	mkdir -p "$HOME/.hmsl/history"

	cat > "$HMSL/labs/testlab/objectives.txt" <<EOF
Test Objective
EOF
	
	hmsl()
	{
		echo "Score : 5/5"
	}
	
	output="$(
		source "${HMSL_ROOT}/lib/exercise.bashrc" >/dev/null 2>&1
		score
	)"
	
	assert_contains \
		"$output" \
		"Exercise complete" \
		"score prints completion message"
	
	unset -f hmsl
	rm -rf "$HMSL"

	cleanup_test_home
}
test_score_complete_message

test_score_incomplete_message()
{
	setup_test_home

	export HMSL="$(mktemp -d)"
	export HMSL_LAB="testlab"
	export HMSL_HISTORY="$HOME/.hmsl/history/testlab.history"

	mkdir -p "$HMSL/labs/testlab"
	mkdir -p "$HOME/.hmsl/history"

	cat > "$HMSL/labs/testlab/objectives.txt" <<EOF
Test Objective
EOF

	hmsl()
	{
		echo "Score : 3/5"
	}

	output="$(
		source "${HMSL_ROOT}/lib/exercise.bashrc" >/dev/null 2>&1
		score
	)"

	assert_contains \
		"$output" \
		"Continue working" \
		"score prints incomplete message"

	unset -f hmsl
	rm -rf "$HMSL"

	cleanup_test_home
}
test_score_incomplete_message

test_summary 


