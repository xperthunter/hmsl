#!/usr/bin/env bash

#set -x

echo
echo "CISS100 LAB01"
echo "============="
echo 


require_command 1 "ran date command" lab01 date

require_command 1 "ran ls" lab01 "ls"

require_command 1 "ran ls -a" lab01 "ls -a"

require_command 1 "ran ls -l" lab01 "ls -l"

require_command 1 "ran ls -la or ls -al" lab01 "ls[[:space:]]+-(la|al)"

summary