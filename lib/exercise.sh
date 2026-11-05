
exercise()
{
	local lab="$1"

	export HMSL_LAB="$lab"
	export HMSL_HISTORY="$HOME/.hmsl/history/${lab}.history"

	mkdir -p "$HOME/.hmsl/history"

	touch "$HMSL_HISTORY"

	bash \
		--rcfile "${HMSL}/lib/exercise.bashrc" \
		-i
}
