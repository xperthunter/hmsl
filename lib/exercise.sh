
exercise_setup()
{
	local lab="$1"

	export HMSL_LAB="$lab"
	export HMSL_HISTORY="$HOME/.hmsl/history/${lab}.history"

    mkdir -p "$HOME/.hmsl/history"
    
    touch "$HMSL_HISTORY"
}

exercise_shell()
{
	bash \
		--rcfile "${HMSL}/lib/exercise.bashrc" \
        -i
}

exercise_instructions()
{
	local lab="$1"

	echo "To practice this exercise again:"
	echo 
	echo "	hmsl reset $lab"
	echo "	hmsl exercise $lab"
}

exercise()
{
	local lab="$1"
	
	exercise_setup "$lab"
	exercise_shell
	exercise_instructions "$lab"
}
