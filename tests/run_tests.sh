#!/usr/bin/env bash

echo "Running HMSL tests"
echo

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Testing HMSL Caller ==="
echo "---------------------------"
source "${SCRIPT_DIR}/test_hmsl_caller.sh"

echo
echo "=== Testing HMSL Exercise ==="
echo "-----------------------------"
source "${SCRIPT_DIR}/test_hmsl_exercise.sh"

echo 
echo "Done."

