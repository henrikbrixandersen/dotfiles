umask 22

export EDITOR=emacsclient
export ALTERNATE_EDITOR=emacs
export PAGER=less
export LESS='-c -i -m -R'
export BLOCKSIZE=K

if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi

# Perl
if [ -d $HOME/perl5 ]; then
    export PERL_LOCAL_LIB_ROOT=$PERL_LOCAL_LIB_ROOT:$HOME/perl5
    export PERL_MB_OPT="--install_base $HOME/perl5"
    export PERL_MM_OPT=INSTALL_BASE=$HOME/perl5
    export PERL5LIB=$HOME/perl5/lib/perl5:$PERL5LIB
    export PATH=$HOME/perl5/bin:$PATH
fi

# GNU Make
if [ -d /opt/make/bin ]; then
    export PATH=/opt/make/bin:$PATH
fi
