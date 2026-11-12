export HMSL_SCORE=0
export HMSL_POSSIBLE=0

CHECKMARK="✓"
XMARK="✗"
GREEN=$'\033[0;32m'
NC=$'\033[0m'

help()
{
	echo "Objectives"
	echo "----------"
	
	cat "${HMSL}/labs/${HMSL_LAB}/objectives.txt"
	
	echo
}

score()
{
	local result
	
	result="$(hmsl score "$HMSL_LAB")"
	echo "$result"
	
	HMSL_SCORE=$(grep "Score :" <<< "$result" | awk '{print $3}' | cut -d/ -f1)
	HMSL_POSSIBLE=$(grep "Score :" <<< "$result" | awk '{print $3}' | cut -d/ -f2)
	
	export HMSL_SCORE
	export HMSL_POSSIBLE
	
	echo
	
	if [[ "$HMSL_SCORE" == "$HMSL_POSSIBLE" ]]; then
		printf "${GREEN}%s Exercise complete.${NC}\n" "$CHECKMARK"
	else
		echo "Continue working and run \`score\` again to continue checking work."
	fi
	
	echo "When finished, type \`finish\` to exit the exercise."
	echo
}

finish()
{
	score
	
	echo
	echo "Leaving exercise..."
	exit
}



printf "\n"
printf "===================================\n"
printf " HMSL Exercise %s\n" "$HMSL_LAB"
printf "===================================\n"
printf "\n"

help

printf "\n"
printf "Commands\n"
printf "	score	Show progress\n"
printf "	help 	Show objectives\n"
printf "	finish	Exit exercise\n"
printf "\n"

export HISTFILE="$HMSL_HISTORY"

export HISTSIZE=1000
export HISTFILESIZE=1000

shopt -s histappend

PROMPT_COMMAND='history -w'

PS1='\[\033[1;36m\][hmsl-${HMSL_LAB} ${HMSL_SCORE}/${HMSL_POSSIBLE}]\[\033[0m\] \u@\h:\W\$ '



