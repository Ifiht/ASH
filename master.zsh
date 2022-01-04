####### SHEBANG PLACEHOLDER ###### - this MUST remain line #1
####### PATH PLACEHOLDER ######### - this MUST remain line #2
####### PROMPT PLACEHOLDER ####### - this MUST remain line #3
#export RPROMPT="%*"
#+===//===> Update all functions
fpath=( $HOME/.ash/func "${fpath[@]}" ) 
####### Source Files #############
autoload -Uz callback
autoload -U colors && colors
[ -f "$HOME/.localz" ] && . "$HOME/.localz"
#+===//===> watch all logins
watch=all
logcheck=40
WATCHFMT="%n from %M has %a tty%l at %T %W"
####### HISTORY ##################
HISTFILE=$HOME/.zhist
HISTSIZE=400
SAVEHIST=1000
TMOUT=0
#+===//===> Treat the '!' character specially during expansion.
setopt BANG_HIST
#+===//===> Write the history file in the ":start:elapsed;command" format.
setopt EXTENDED_HISTORY
#+===//===> Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
#+===//===> Share history between all sessions.
setopt SHARE_HISTORY
#+===//===> Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
#+===//===> Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
#+===//===> Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
#+===//===> Do not display a line previously found.
setopt HIST_FIND_NO_DUPS
#+===//===> Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS
#+===//===> Don't execute immediately upon history expansion.
setopt HIST_VERIFY
export ZSH=$HOME/.ash
export PATH="$HOME/bin:$PATH"
export TMOUT
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
export CLICOLOR=1
export ZPLUG_HOME="$HOME/.ash/zplug"
[ -n "$SSH_TTY" ] && TMOUT=600
[ -n "$STY" ] && TMOUT=0
#+===//===> Use modern completion system, only run on last 24 hours (speed hack!)
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
#+===//===> completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
#+===//===> cache path
zstyle ':completion:*' cache-path ~/.zsh/cache
#+===//===> ignore case
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' #menu if nb items > 2
zstyle ':completion:*' menu select=2
#+===//===> colorz !
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 
#+===//===> list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate 
#+===//===> ZSH auto-suggestions
source $ZSH/submodules/z-suggestions/zsh-autosuggestions.zsh
#+===//===> Aliases
alias quit="exit"
alias dv="cd /home/git"
