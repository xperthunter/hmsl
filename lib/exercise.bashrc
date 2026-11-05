
export HISTFILE="$HMSL_HISTORY"

export HISTSIZE=1000
export HISTFILESIZE=1000

shopt -s histappend

PROMPT_COMMAND='history -a'

PS1="exercise ${HMSL_LAB}$ "
