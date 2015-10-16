umask 22

export EDITOR=emacsclient
export ALTERNATE_EDITOR=emacs
export PAGER=less
export LESS='-c -i -m -R'
export BLOCKSIZE=K

if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi

# GNU Make
if [ -d /opt/make/bin ]; then
    export PATH=/opt/make/bin:$PATH
fi

# Xilinx ISE
if [ -d /opt/Xilinx ]; then
    latest=`ls -d /opt/Xilinx/* | sort -n | tail -n 1`
    if [ -n "$latest" ]; then
	export XILINX=$latest/ISE_DS/ISE
	export PATH=$XILINX/bin/lin64:$PATH
    fi
fi
