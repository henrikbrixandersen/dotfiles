## Unique elements in $path and $fpath
typeset -U path
typeset -U fpath

## Local ZSH functions
if [[ -d ~/.zsh/functions ]]; then
    fpath=(~/.zsh/functions $fpath)
fi

## Slic3r ZSH functions
if [[ -d ~/Projects/github/Slic3r/utils/zsh/functions ]]; then
    fpath=(~/Projects/github/Slic3r/utils/zsh/functions $fpath)
fi

## Global environment
export LC_ALL=en_US.UTF-8
export TZ=Europe/Copenhagen

## NXJ
if [[ -d ~/nxj/bin ]]; then
    export NXJ_HOME=~/nxj
    path=($NXJ_HOME/bin $path)
fi

## MacTeX
if [[ -d /usr/texbin ]]; then
    path=(/usr/texbin $path)
fi

## ImageMagick
if [[ -d /usr/local/ImageMagick/bin ]]; then
    path=(/usr/local/ImageMagick/bin $path)
fi

# Pepper
if [[ -d ~/Projects/svn.brixandersen.dk/pepper-data ]]; then
    export PEPPER_CONF=~/Projects/svn.brixandersen.dk/pepper-data/etc/pepper.conf
fi

## Local perl5lib
if [[ -d ~/perl5/lib ]]; then
    #eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
    export PERL_LOCAL_LIB_ROOT="$HOME/perl5"
    export PERL_MB_OPT="--install_base $HOME/perl5"
    export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
    export PERL5LIB="$HOME/perl5/lib/perl5/darwin-thread-multi-2level:$HOME/perl5/lib/perl5"
    path=($HOME/perl5/bin $path)
fi

## Local rubygem
if [[ -d $HOME/rubygems ]]; then
    export GEM_HOME=$HOME/rubygems
    path=($GEM_HOME/bin $path)
fi

## Development perl5lib
if [[ -d ~/Projects/svn.brixandersen.dk/perl5lib ]]; then
    export PERL5LIB=$HOME/Projects/svn.brixandersen.dk/perl5lib:$PERL5LIB
fi

## Local bin
path=(~/bin $path)
