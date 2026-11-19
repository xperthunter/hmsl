#!/usr/bin/env bash

test_exercise_creates_history_dir()
{
	rm -rf "$HOME/.hmsl"

	bash() { return 0; }

	source ../lib/exercise.sh

	exercise "lab01"

	[[ -d "$HOME/.hmsl/history" ]]
}

test_exercise_creates_history_dir
