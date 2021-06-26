#!/bin/zsh
# vim: set foldlevel=0 foldmethod=marker:

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zplugin {{{
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# TODO zplug "plugins/ruby", from:oh-my-zsh
# TODO zplug "plugins/rails", from:oh-my-zsh
# TODO zplug "plugins/gem", from:oh-my-zsh
# TODO zplug "plugins/tmuxinator", from:oh-my-zsh
# TODO zplug "plugins/docker", from:oh-my-zsh
# TODO zplug "plugins/docker-compose", from:oh-my-zsh

# TODO zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-completions

zplug chrissicool/zsh-256color
zplug romkatv/powerlevel10k, as:theme, depth:1

zplug load
# }}}

fpath+=~/.zfunc
fpath+=~/.oh-my-zsh/completions

# General Settings {{{
# Autoload tab completion {{{
#-------------------------------------------------------------------------------
autoload bashcompinit
bashcompinit
autoload -U compinit
compinit -C
# }}}
# Modify default zsh directory coloring on ls commands {{{
#-------------------------------------------------------------------------------
export LSCOLORS=gxfxcxdxbxegedabagacad
# }}}
# Completion settings {{{
#-------------------------------------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "$LS_COLORS"
zstyle -e ':completion:*:(ssh|scp|sshfs|ping|telnet|nc|rsync):*' hosts '
    reply=( ${=${${(M)${(f)"$(<~/.ssh/config)"}:#Host*}#Host }:#*\**} )'
# }}}
# Set the desired setup options man zshoptions {{{
#-------------------------------------------------------------------------------
# If command can't be executed, and command is name of a directory, cd to directory
setopt  auto_cd
# Make cd push the old directory onto the directory stack.
setopt  auto_pushd
# Safety for overwriting files use >| instead of > to over write files
setopt  noclobber
# Prevents aliases on the command line from being internally substituted before
# completion is attempted. The effect is to make the alias a distinct command
# for completion purposes.
setopt  complete_aliases
## TODO # Treat the #, ~ and ^ characters as part of patterns for filename
## TODO # generation, etc.  (An initial unquoted `~' always produces named directory
## TODO # expansion.)
## TODO setopt  extended_glob
## TODO # If a new command line being added to the history list duplicates an older one,
## TODO # the older command is removed from the list (even if it is not the previous event).
## TODO setopt  hist_ignore_all_dups
## TODO #  Remove command lines from the history list when the first character on the line
## TODO #  is a space, or when one of the expanded aliases contains a leading space.
## TODO setopt  hist_ignore_space
## TODO # This  option  both  imports new commands from the history file, and also
## TODO # causes your typed commands to be appended to the history file
## TODO setopt  share_history
## TODO setopt  noflowcontrol
## TODO # When listing files that are possible completions, show the type of each file
## TODO # with a trailing identifying mark.
## TODO setopt  list_types
## TODO # Append a trailing / to all directory names resulting from filename
## TODO # generation (globbing).
## TODO setopt  mark_dirs
## TODO # Perform a path search even on command names with slashes in them.
## TODO # Thus if /usr/local/bin is in the user's path, and he or she types
## TODO # X11/xinit, the  command /usr/local/bin/X11/xinit will be executed
## TODO # (assuming it exists).
## TODO setopt  path_dirs
## TODO # If set, `%' is treated specially in prompt expansion.
## TODO setopt  prompt_percent
## TODO # If set, parameter expansion, command substitution and arithmetic
## TODO # expansion are performed in prompts.
## TODO # Substitutions within prompts do not affect the command status.
## TODO setopt  prompt_subst
# }}}
# History settings {{{
#-------------------------------------------------------------------------------
HISTFILE=$HOME/.zsh_history
HISTFILESIZE=65536  # search this with `grep | sort -u`
HISTSIZE=4096
SAVEHIST=4096
REPORTTIME=60       # Report time statistics for progs that take more than a minute to run
# }}}
# utf-8 in the terminal, will break stuff if your term isn't utf aware {{{
#-------------------------------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LC_COLLATE=C
# }}}
# Set grepoptions {{{
#-------------------------------------------------------------------------------
export GREP_OPTIONS='--color=auto'
# }}}
# Editor and display configurations {{{
#-------------------------------------------------------------------------------
export EDITOR='nvim'
export VISUAL='nvim'
export GIT_EDITOR=$EDITOR
export LESS='-imJMWR'
export PAGER="less $LESS"
export MANPAGER=$PAGER
export GIT_PAGER=$PAGER
# }}}
# Specify virtualenv directory {{{
export WORKON_HOME=$HOME/.virtualenvs
# }}}
# Eliminate lag between transition from normal/insert mode {{{
#-------------------------------------------------------------------------------
# If this causes issue with other shell commands it can be raised default is 4
export KEYTIMEOUT=1
# }}}
# }}}

# Aliases {{{
alias rm="rm -i"
alias l="ls -CF"
alias less="less -S"
alias vim="nvim"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias hstart="/usr/local/cloudera/sbin/start-dfs.sh;/usr/local/cloudera/sbin/start-yarn.sh"
alias hstop="/usr/local/cloudera/sbin/stop-yarn.sh;/usr/local/cloudera/sbin/stop-dfs.sh"
alias fix='echo -e "\033c"'
alias kc="kubectl"
alias kcgpa="kubectl get pods --all-namespaces"
# }}}

bindkey -e
# TODO
# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

# environment varaibles {{{
if [ -f ~/.env ]; then
  source ~/.env
fi
# }}}

export GOPATH=$HOME/go

# TODO
export PATH="~/Library/Python/3.8/bin:~/Library/Python/2.7/bin:~/go/bin:$(go env GOBIN):$PATH"
export PATH="${PATH}:${HOME}/.krew/bin"
export PATH=$PATH:/usr/local/kubebuilder/bin
export PATH=$PATH:/usr/local/kubectx/bin
export PATH=$PATH:~/.cargo/bin

# rbenv {{{
eval "$(rbenv init -)"
# }}}

GPG_TTY=$(tty)
export GPG_TTY
export CLICOLOR=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"
export PATH="/usr/local/sbin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
