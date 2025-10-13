# vim: set foldlevel=0 foldmethod=marker:

if status is-interactive
  # Commands to run in interactive sessions can go here
end

/opt/homebrew/bin/brew shellenv | source

set -gx EDITOR nvim
set -gx GPG_TTY (tty)

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

# mise {{{
if type -q mise then
  mise activate fish | source
end
# }}}

# fzf {{{
if type -q fish then
  fzf --fish | source
end
# }}}

# ruby settings {{{
if type -q rbenv
  set -gx  RBENV_ROOT "$XDG_DATA_HOME/rbenv"
  fish_add_path $RBENV_ROOT/bin
end
if type -q ruby
  set -gx BUNDLE_USER_HOME "$XDG_DATA_HOME/bundle"
  set -gx BUNDLE_USER_CONFIG "$XDG_CONFIG_HOME/bundle/config"
  set -gx BUNDLE_USER_CACHE "$XDG_CACHE_HOME/bundle"
  set -gx BUNDLE_USER_PLUGIN "$XDG_DATA_HOME/bundle/plugin"
  set -gx IRBRC "$XDG_CONFIG_HOME/irb/irbrc"
  set -gx SOLARGRAPH_CACHE $XDG_CACHE_HOME
end
# }}}

# rust settings {{{
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx PATH "$CARGO/bin:$PATH"
# }}}

# go settings {{{
set -gx GOENV_ROOT "$XDG_DATA_HOME/goenv"
set -gx GOENV_GOPATH_PREFIX "$XDG_DATA_HOME/goenv/modules"
# }}}

# PostgreSQL XDG {{{
set -gx PSQLRC "$XDG_CONFIG_HOME/postgres/rc"
set -gx PSQL_HISTORY "$XDG_STATE_HOME/postgres/history"
set -gx PGPASSFILE "$XDG_CONFIG_HOME/postgres/pass"
set -gx PGSERVICEFILE "$XDG_CONFIG_HOME/postgres/service.conf"
# }}}

# ACK XDG {{{
set -gx ACKRC "$XDG_CONFIG_HOME/ack/ackrc"
# }}}

# aws cli XDG {{{
set -gx AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials"
set -gx AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"
# }}}

# docker XDG {{{
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx MACHINE_STORAGE_PATH "$XDG_DATA_HOME/docker/machine"
# }}}

# GnuPG XDG {{{
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
# }}}

# node XDG {{{
set -gx NODE_REPL_HISTORY "$XDG_STATE_HOME/node/repl_history"
# }}}

# readline XDG {{{
set -gx INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"
# }}}

# zoxide {{{
if type -q zoxide then
  zoxide init fish | source
end
# }}}

starship init fish | source
