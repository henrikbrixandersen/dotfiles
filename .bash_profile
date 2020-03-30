# ~/.bashrc
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Local profile.d
if [ -d $HOME/.local/etc/profile.d ]; then
    for f in $HOME/.local/etc/profile.d/*; do
        source $f
    done
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
case `uname -s` in
    Linux)
        export CLICOLOR=1
        export LS_COLORS='di=34;1:ln=35:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
        #export LS_COLORS='di=34;1:ln=35:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46'
        alias ls='ls --color=auto'
        ;;

    Darwin)
        alias ls='ls -G'
        ;;
esac

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
        sed -i -e "/^$_hostname,/d" $HOME/.ssh/known_hosts
        sed -i -e "/^$1[[:space:]]/d" $HOME/.ssh/known_hosts
    done
}

_remove-ssh-hostkey() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W "`cut -d ',' -f 1 $HOME/.ssh/known_hosts | cut -d ' ' -f 1`" -- $cur))
}
complete -F _remove-ssh-hostkey remove-ssh-hostkey

add-ssh-authorized-keys() {
    ssh $1 'mkdir ~/.ssh; chmod 700 ~/.ssh'
    scp $HOME/.ssh/authorized_keys $1:~/.ssh/
}
complete -F _known_hosts add-ssh-authorized-keys

strip-dmesg() {
    if [ -z "$1" ]; then
        echo "Usage: strip-dmesg FILE" >&2
    else
        dos2unix $1
        sed -i -e 's/^\[[ \t0-9\.]*\] //g' $1
    fi
}

zephyr() {
    local _zephyr_dir

    if [ -n "$1" ]; then
       _zephyr_dir="$1"
    else
       _zephyr_dir="$HOME/Projects/zephyrproject/zephyr"
    fi

    if [ -f "$_zephyr_dir/zephyr-env.sh" ]; then
        source "$_zephyr_dir/zephyr-env.sh"
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

xilinx_vivado() {
    local args quiet version

    args=`getopt q $*`
    if [ $? -ne 0 ]; then
        echo "Usage: xilinx_vivado [-q] [VERSION]"
        return 1
    fi

    set -- $args
    for i; do
        case "$i" in
            -q)
                quiet=1
                shift;;
            --)
                shift; break;;
        esac
    done

    if [ -n "$1" ]; then
        version="$1"
    else
        version=`basename \`ls -d /opt/Xilinx/Vivado/* | sort | tail -n 1\``
    fi

    _unset_xilinx_env
    if [ -f /opt/Xilinx/Vivado/$version/settings64.sh ]; then
        if [ "$quiet" != "1" ]; then
            echo "Setting up environment for Xilinx Vivado $version"
        fi
        source /opt/Xilinx/Vivado/$version/settings64.sh
    else
        echo "Xilinx Vivado $version not found"
        return 1
    fi
}

_xilinx_vivado() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W "`cd /opt/Xilinx/Vivado && ls -d *`" -- $cur))
}
complete -F _xilinx_vivado xilinx_vivado

#if [ -d /opt/Xilinx/Vivado ]; then
#    xilinx_vivado -q
#fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
