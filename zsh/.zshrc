#!/bin/zsh
# vim: set foldlevel=0 foldmethod=marker:

# p10k start {{{
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }}}

# zplugin {{{
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "plugins/docker", from:oh-my-zsh
# zplug "plugins/asdf", from:oh-my-zsh

zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-completions

zplug chrissicool/zsh-256color
zplug romkatv/powerlevel10k, as:theme, depth:1

zplug load
# }}}

# General Settings {{{
# Autoload tab completion {{{
#-------------------------------------------------------------------------------
autoload bashcompinit
bashcompinit
autoload -U compinit
compinit -C
fpath+="${ZDOTDIR}/.zfunc"
# }}}
# Modify default zsh directory coloring on ls commands {{{
#-------------------------------------------------------------------------------
export LSCOLORS=gxfxcxdxbxegedabagacad
export GPG_TTY=$TTY
export CLICOLOR=1
# }}}
# Completion settings {{{
#-------------------------------------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "$LS_COLORS"
zstyle -e ':completion:*:(ssh|scp|sshfs|ping|telnet|nc|rsync):*' hosts '
    reply=( ${=${${(M)${(f)"$(<~/.ssh/config)"}:#Host*}#Host }:#*\**} )'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
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
# Treat the #, ~ and ^ characters as part of patterns for filename
# generation, etc.  (An initial unquoted `~' always produces named directory
# expansion.)
setopt  extended_glob
# If a new command line being added to the history list duplicates an older one,
# the older command is removed from the list (even if it is not the previous event).
setopt  hist_ignore_all_dups
#  Remove command lines from the history list when the first character on the line
#  is a space, or when one of the expanded aliases contains a leading space.
setopt  hist_ignore_space
# This  option  both  imports new commands from the history file, and also
# causes your typed commands to be appended to the history file
setopt  share_history
setopt  noflowcontrol
# When listing files that are possible completions, show the type of each file
# with a trailing identifying mark.
setopt  list_types
# Append a trailing / to all directory names resulting from filename
# generation (globbing).
setopt  mark_dirs
# Perform a path search even on command names with slashes in them.
# Thus if /usr/local/bin is in the user's path, and he or she types
# X11/xinit, the  command /usr/local/bin/X11/xinit will be executed
# (assuming it exists).
setopt  path_dirs
# If set, `%' is treated specially in prompt expansion.
setopt  prompt_percent
# If set, parameter expansion, command substitution and arithmetic
# expansion are performed in prompts.
# Substitutions within prompts do not affect the command status.
setopt  prompt_subst
# }}}
# History settings {{{
#-------------------------------------------------------------------------------
HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history
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
# Eliminate lag between transition from normal/insert mode {{{
#-------------------------------------------------------------------------------
# If this causes issue with other shell commands it can be raised default is 4
export KEYTIMEOUT=1
# }}}
# }}}

# Aliases {{{
alias rm="rm -i"
alias l="l -CF"
alias less="less -S"
alias vim="nvim"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias fix='echo -e "\033c"'
alias kc="kubectl"
alias kcgpa="kubectl get pods --all-namespaces"
alias ls="lsd"
alias vnone="vim -u NONE -U NONE -N -i NONE"
# }}}

# edit command line {{{
bindkey -e
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# }}}

# environment varaibles {{{
if [ -f ~/.env ]; then
  source ~/.env
fi
# }}}

# path {{{
# TODO: clean this up
export GOPATH=$HOME/go
export PATH=$PATH:~/go/bin
export PATH="${PATH}:${HOME}/.krew/bin"
export PATH=$PATH:/usr/local/kubebuilder/bin
export PATH=$PATH:/usr/local/kubectx/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:/usr/local/opt/llvm/bin
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
export PATH="${HOME}/.local/bin:$PATH"
# }}}

# ruby settings {{{
if (( $+commands[rbenv] )); then
  export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
  eval "$(rbenv init - zsh --no-rehash)"
  export PATH="$RBENV_ROOT/bin:$PATH"
fi
export SOLARGRAPH_CACHE=${XDG_CACHE_HOME}
# }}}

# fzf {{{
[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh
# }}}

# source p10k prompt {{{
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
# }}}

# asdf {{{
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
# . /usr/local/opt/asdf/asdf.sh
# . /usr/local/opt/asdf/libexec/asdf.sh
# }}}
