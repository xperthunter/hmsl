#!/usr/bin/env bash

exercise="$1"

session_id=$(date +%s)
history_file="$HOME/${exercise}_${session_id}.history"

export EXERCISE_NAME="$exercise"
export EXERCISE_HISTFILE="$history_file"

bash --noprofile --rcfile $HOME/exercise.rc -i

echo "exercise is done"


