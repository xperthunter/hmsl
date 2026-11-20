#!/usr/bin/env bash

echo "Running HMSL tests"
echo

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Testing HMSL Caller ==="
echo "---------------------------"
source "${SCRIPT_DIR}/test_caller.sh"

echo
echo "=== Testing HMSL Exercise ==="
echo "-----------------------------"
source "${SCRIPT_DIR}/test_exercise.sh"

echo 
echo "===  Testing HMSL Score   ==="
echo "-----------------------------"
source "${SCRIPT_DIR}/test_score.sh"

echo
echo "=== Testing HMSL Reset ==="
echo "--------------------------"
source "${SCRIPT_DIR}/test_reset.sh"


echo 
echo "Done."

