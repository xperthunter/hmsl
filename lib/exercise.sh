
CALLER="$(readlink -f "$0")"
HMSL="$(cd "$(dirname "$CALLER")/.." && pwd)"

exercise()
{
	local lab="$1"
	export HMSL="$HMSL"
	export HMSL_LAB="$lab"
	export HMSL_HISTORY="$HOME/.hmsl/history/${lab}.history"

	mkdir -p "$HOME/.hmsl/history"

	touch "$HMSL_HISTORY"
	
	bash \
		--rcfile "${HMSL}/lib/exercise.bashrc" \
		-i
	
	echo
	echo "To practice this exercise again:"
	echo 
	echo "	hmsl reset $lab"
	echo "	hmsl exercise $lab"
	
}
