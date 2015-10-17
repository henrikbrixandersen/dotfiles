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
