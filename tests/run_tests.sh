#!/usr/bin/env bash

echo "Running HMSL tests"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/test_hmsl_caller.sh"

echo "Done."
