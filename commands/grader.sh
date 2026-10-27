
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
