# ~/.bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Aliases
alias ll='ls -lA'
alias rmbak='rm -vf *~ .*~'

# Colors
export CLICOLOR=1
export LS_COLORS='di=34;1:ln=35:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
#export LS_COLORS='di=34;1:ln=35:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46'

## Terminal specific settings
case $TERM in
    xterm*)
	PS1="\[\e]0;\u@\h:\w\a\][\u@\h:\w]\$ "
        ;;
    screen*)
	PS1="\[\e]0;\u@\h:screen:\w\a\][\u@\h:\w]\$ "
        ;;
    *)
	unset PROMPT_COMMAND
        ;;
esac
