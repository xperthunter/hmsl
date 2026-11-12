#!/usr/bin/env bash

#set -x

echo
echo "CISS100 LAB01"
echo "============="
echo 


require_command 1 "ran date command" date

require_command 1 "ran ls" "ls"

require_command 1 "ran ls -a" "ls -a"

require_command 1 "ran ls -l" "ls -l"

require_command 1 "ran ls -la or ls -al" "ls[[:space:]]+-(la|al)"

summary
