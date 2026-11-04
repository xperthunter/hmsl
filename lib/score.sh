
score=0
possible=0

check() {
	local points="$1"
	local description="$2"
	shift 2

	possible=$((possible + points))

	if "$@" >/dev/null 2>&1; then
		printf "[PASS] %-45s %d/%d\n" \
			"$description" "$points" "$points"
		score=$((score + points))
	else
		printf "[FAIL] %-45s 0/%d\n" \
			"$description" "$points"
	fi
}

history_contains()
{
	local pattern="$1"

	history | grep -Eq "$pattern"
}

last_reset()
{
	local lab="$1"

	history |
	grep -E "[[:space:]]+hmsl reset $lab$" |
	tail -n 1 |
	awk '{print $1}'
}

history_since_reset()
{
	local lab="$1"
	
	local reset

	reset="$(last_reset "$lab")"

	if [[ -z "$reset" ]]; then
		history
		return
	fi

	echo "$reset"

	history |
	awk -v start="$reset" '$1 > start'
}

history_contains_since_reset()
{
	local lab="$1"
	local pattern="$2"

	echo "PATTERN: $pattern"
	history_since_reset "$lab" |
	grep -Eq "[[:space:]]+$pattern$"
}

require_command()
{
	local points="$1"
	local description="$2"
	local lab="$3"
	local command="$4"
	echo "COMMAND: $command"
	check \
		"$points" \
		"$description" \
		history_contains_since_reset \
		"$lab" \
		"$command"
}

finish()
{
	echo
	echo "=============================="
	echo "Score : $score/$possible"
	echo "=============================="
}


