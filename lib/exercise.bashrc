
printf "\n"
printf "===================================\n"
printf " HMSL Exercise %s\n" "$HMSL_LAB"
printf "===================================\n"
printf "\n"

export HISTFILE="$HMSL_HISTORY"

export HISTSIZE=1000
export HISTFILESIZE=1000

shopt -s histappend

PROMPT_COMMAND='history -a'

PS1='\[\033[1;36m\][hmsl-${HMSL_LAB}]\[\033[0m\] \u@\h:\W\$ '
