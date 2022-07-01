umask 22

export EDITOR=emacsclient
export ALTERNATE_EDITOR=emacs
export PAGER=less
export LESS='-c -i -m -R'
export BLOCKSIZE=K
export QUOTING_STYLE=literal

if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi

# $HOME/.local
if [ -d $HOME/.local ]; then
    # PATH
    if [ -d $HOME/.local/bin ]; then
        export PATH=$HOME/.local/bin:$PATH
    fi
    if [ -d $HOME/.local/sbin ]; then
        export PATH=$HOME/.local/sbin:$PATH
    fi
    # LD_LIBRARY_PATH
    if [ -d $HOME/.local/lib ]; then
        export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
    fi
    if [ -d $HOME/.local/lib64 ]; then
        export LD_LIBRARY_PATH=$HOME/.local/lib64:$LD_LIBRARY_PATH
    fi
    # PKG_CONFIG_PATH
    if [ -d $HOME/.local/lib/pkgconfig ]; then
        export PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH
    fi
    if [ -d $HOME/.local/lib64/pkgconfig ]; then
        export PKG_CONFIG_PATH=$HOME/.local/lib64/pkgconfig:$PKG_CONFIG_PATH
    fi
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
