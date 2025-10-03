#!/bin/zsh
# vim: set foldlevel=0 foldmethod=marker:

if (( $+commands[brew] )); then
  # If you're using macOS, you'll want this enabled
  eval "$(brew shellenv)"
fi

### Added by Zinit's installer {{{
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk }}}

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# General Settings {{{
# Autoload tab completion {{{
#-------------------------------------------------------------------------------
autoload -Uz compinit bashcompinit && compinit -C && bashcompinit
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
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# TODO fzf-tab not working
# zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
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
SAVEHIST=$HISTSIZE
HISTDUP=erase
REPORTTIME=60       # Report time statistics for progs that take more than a minute to run
setopt appendhistory
#  Remove command lines from the history list when the first character on the line
#  is a space, or when one of the expanded aliases contains a leading space.
setopt hist_ignore_space
# This  option  both  imports new commands from the history file, and also
# causes your typed commands to be appended to the history file
setopt share_history
# If a new command line being added to the history list duplicates an older one,
# the older command is removed from the list (even if it is not the previous event).
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
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
# }}}

# Aliases {{{
alias rm="rm -i"
alias l="l -CF"
alias less="less -S"
alias vim="nvim"
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

# ruby settings {{{
if (( $+commands[rbenv] )); then
  export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
  eval "$(rbenv init - zsh --no-rehash)"
  export PATH="$RBENV_ROOT/bin:$PATH"
  export BUNDLE_USER_HOME="$XDG_DATA_HOME/bundle"
  export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle/config"
  export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
  export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle/plugin"
  export IRBRC="$XDG_CONFIG_HOME/irb/irbrc"
fi
export SOLARGRAPH_CACHE=${XDG_CACHE_HOME}
# }}}

# rust settings {{{
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PATH="$CARGO/bin:$PATH"
# }}}

# go settings {{{
export GOENV_ROOT="$XDG_DATA_HOME/goenv"
export GOENV_GOPATH_PREFIX="$XDG_DATA_HOME/goenv/modules"
# }}}

# PostgreSQL XDG {{{
export PSQLRC="$XDG_CONFIG_HOME/postgres/rc" \
  PSQL_HISTORY="$XDG_STATE_HOME/postgres/history" \
  PGPASSFILE="$XDG_CONFIG_HOME/postgres/pass" \
  PGSERVICEFILE="$XDG_CONFIG_HOME/postgres/service.conf"
# }}}

# ACK XDG {{{
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
# }}}

# aws cli XDG {{{
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials" \
  AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
# }}}

# docker XDG {{{
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker/machine"
# }}}

# GnuPG XDG {{{
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
# }}}

# node XDG {{{
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node/repl_history"
# }}}

# readline XDG {{{
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
# }}}

# fzf {{{
if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
fi
# }}}

# zoxide {{{
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi
# }}}

eval "$(starship init zsh)"
