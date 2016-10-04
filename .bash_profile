# ~/.bashrc
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Aliases
alias ll='ls -lA'
alias rmbak='rm -vf *~ .*~'
alias ec='emacsclient'
alias cgrep="grep --color=always"

# Shell options
if shopt | grep -q direxpand; then
	shopt -s direxpand
fi

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

remove-ssh-hostkey() {
    local _hostname

    for _hostname in $*; do
        sed -i -e "/^$_hostname,/d" -e "/^$1[[:space:]]/d" $HOME/.ssh/known_hosts
    done
}

_remove-ssh-hostkey() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W "`cut -d ',' -f 1 $HOME/.ssh/known_hosts | cut -d ' ' -f 1`" -- $cur))
}
complete -F _remove-ssh-hostkey remove-ssh-hostkey

strip-dmesg() {
    if [ -z "$1" ]; then
	echo "Usage: strip-dmesg FILE" >&2
    else
	dos2unix $1
	sed -i -e 's/^\[[ \t0-9\.]*\] //g' $1
    fi
}

_unset_xilinx_env() {
    local _var
    local _path
    local _NEWPATH

    for _var in `env|grep ^XILINX | cut -d = -f 1`; do
	unset $_var
    done

    for _path in `echo $PATH | tr : ' '`; do
	if ! echo $_path | grep -qi xilinx; then
	    _NEWPATH=$_NEWPATH:$_path
	fi
    done
    export PATH=`echo $_NEWPATH | sed -e 's/^://'`

    for _path in `echo $LD_LIBRARY_PATH | tr : ' '`; do
	if ! echo $_path | grep -qi xilinx; then
	    _NEWPATH=$_NEWPATH:$_path
	fi
    done
    export LD_LIBRARY_PATH=`echo $_NEWPATH | sed -e 's/^://'`
}

xilinx_ise() {
#    echo "Setting up environment for Xilinx 14.7"
    _unset_xilinx_env
    source /opt/Xilinx/14.7/ISE_DS/settings64.sh
}

xilinx_vivado() {
    local version=`basename \`ls -d /opt/Xilinx/Vivado/* | sort | head -n 1\``

#    echo "Setting up environment for Xilinx Vivado $version"
    _unset_xilinx_env
    source /opt/Xilinx/Vivado/$version/settings64.sh
}
xilinx_vivado
