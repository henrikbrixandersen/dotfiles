## Misc. settings
export EDITOR=emacs
export PAGER=less
export LESS='-c -i -m -R'
export BLOCKSIZE=K
setopt LOCAL_OPTIONS
unsetopt BG_NICE
umask 022

## Colors
#autoload -Uz colors
#colors
export CLICOLOR=1
export LS_COLORS='di=34;1:ln=35:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43' # GNU ls(1)
export LSCOLORS='Exfxcxdxcxegedabagacad' # BSD ls(1)
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='36;1'

## Aliases
alias ll='ls -lA'
alias h='history'
alias ec='emacsclient'
alias perllocalupgrade="perldoc -t perllocal | grep Module | sed -e 's/^.* \"Module\" //' -e 's/-/::/g' | sort | uniq | xargs cpan -i"

## Named directories
hash -d svn=~/Projects/svn.brixandersen.dk/
hash -d github=~/Projects/github/

## Local functions
autoload -U ~/.zsh/functions/*[^~](:t)

## History
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## Help
unalias run-help
autoload -Uz run-help
HELPDIR=~/.zsh/help

## Reporting
REPORTTIME=10
setopt PRINT_EXIT_VALUE

## Keybindings
bindkey -e
bindkey -r "^[A" # remove accept-and-hold
bindkey -r "^[a" # remove accept-and-hold

## ZLE
zstyle ':zle:*' word-style standard
zstyle ':zle:*' word-chars ''
export WORDCHARS='*?_[]~=&;!#$%^(){}'

## Recent directories
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file ~/.zrecentdirs
zstyle ':completion:*:*:cdr:*:*' menu selection
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
DIRSTACKSIZE=20
zstyle ':completion:*:*:cd:*:directory-stack' menu selection

## Completions
zmodload -i zsh/complist
autoload -Uz compinit
compinit
zstyle ':completion:*' verbose true
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for %d'
zstyle ':completion:*' group-name '%d'
#zstyle ':completion:*' show-completer true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' '+m:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
zstyle ':completion:*' insert-tab pending
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zstyle ':completion:*:*:kill:*' menu selection
zstyle ':completion:*:*:*:users' ignored-patterns '_*' toor cyrus \
    daemon operator bin tty kmem games news man sshd smmsp mailnull \
    bind proxy uucp pop nobody bitlbee mysql postfix www git_daemon
zstyle ':completion:*:*:*:hosts' ignored-patterns broadcasthost
zstyle ':completion:*:*:*:functions' ignored-patterns '_*'

## VCS information
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable cvs git svn
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' formats '[%s %b]'
zstyle ':vcs_info:*' actionformats '[%s:%B%a%%b %b]'
zstyle ':vcs_info:git*:*' formats '[%s %b@%.10i]'
zstyle ':vcs_info:git*:*' actionformats '[%s:%B%a%%b %b@%.10i]'
zstyle ':vcs_info:svn:*' branchformat '%b@%r'

## Prompts
setopt PROMPT_SUBST
PROMPT='%(!.%m%#.[%n@%m:%B%~%b]%#) '
RPROMPT='${vcs_info_msg_0_}'

## Terminal specific settings
case $TERM in
    xterm*)
	precmd () { print -Pn '\e]0;%n@%m:%~\a'; vcs_info }
	preexec () { print -Pn '\e]0;%n@%m:$2\a' }
	;;
    screen*)
	precmd () { print -Pn '\e]0;%n@%m:screen:%~\a'; vcs_info }
	preexec () { print -Pn '\e]0;%n@%m:screen:$2\a' }
	;;
    *)
	precmd () { vcs_info }
	;;
esac
