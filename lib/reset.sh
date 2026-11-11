
reset_history()
{
	local lab="$1"

	rm -f "$HOME/.hmsl/history/${lab}.history"

	touch "$HOME/.hmsl/history/${lab}.history"
}


reset_lab()
{
	local lab="$1"

	reset_history "$lab"

	source "${HMSL}/labs/${lab}/reset.sh"

	echo
	echo "$lab reset successfully."
}
