# Setup {{{
_os="$(uname -s)"
case "$_os" in
	Darwin)
		_id=/usr/bin/id
	;;
esac
# }}}
# Functions {{{
# cleanup {{{
# unsets outstanding environment variables and itself
cleanup() {
	unset _os _id
	unset cleanup
}
# }}}
# safe_source {{{
##
# Sources all existing files in a list of files. Every file that is readable
# will get sourced as a shorthand to listing many lines of safe_source.
#
# Thanks to: https://github.com/darkhelmet/dotfiles for inspiration.
#
# @param [List] space-separated list of source files
safe_source() {
	for src ; do
		[[ -r "$src" ]] && source "$src"
	done ; unset src
}
# }}}
# __push_path {{{
##
# Pushes paths to the front of a search path variable list.
#
# @param [String] path variable to manipulate (ex: PATH, PYTHONPATH, etc)
# @param [List] space-seperated list of system paths to push, in reverse order
__push_path() {
	local path_var="$1"
	shift

	# create var if not exists
	if eval "test -z \"\$$path_var\"" ; then
		[[ -d "$1" ]] && eval $path_var="$1"
		shift
	fi

	for p in $@ ; do
		__remove_from_path "$path_var" "$p"
		[[ -d "$p" ]] && eval $path_var="${p}:\$${path_var}"
	done ; unset p
}
#}}}
# __remove_from_path {{{
##
# Removes all instances of paths in a search path.
#
# @param [String] path variable to manipulate (ex: PATH, PYTHONPATH, etc)
# @param [List] space-seperated list of system paths to remove
__remove_from_path() {
	local path_var="$1"
	shift
	local new_path=""

	case "$(uname -s)" in
		SunOS)
			local tr_cmd=/usr/gnu/bin/tr
			local grep_cmd=/usr/gnu/bin/grep
		local sed_cmd=/usr/gnu/bin/sed
		;;
		*)
			local tr_cmd=tr
			local grep_cmd=grep
			local sed_cmd=sed
		;;
  esac

	# remove paths from path_var, working in new_path
	for rp in $@ ; do
		new_path="$(eval "echo \"\$$path_var\"" | $tr_cmd ':' '\n' | \
			$grep_cmd -v "^${rp}$" | $tr_cmd '\n' ':' | $sed_cmd -e 's/:$//')"
	done ; unset rp

	# reassign path_var from new_path
	eval $path_var="$new_path"
}
# }}}
# bput {{{
##
# Prints terminal codes.
#
# Thanks to: http://github.com/wayneeseguin/rvm/blob/master/scripts/color
#
# @param [String] terminal code keyword (usually a color)
bput() {
	case "$1" in
		# regular colors
		black)    tput setaf 0 ;;
		red)      tput setaf 1 ;;
		green)    tput setaf 2 ;;
		yellow)   tput setaf 3 ;;
		blue)     tput setaf 4 ;;
		magenta)  tput setaf 5 ;;
		cyan)     tput setaf 6 ;;
		white)    tput setaf 7 ;;

		# emphasized (bolded) colors
		eblack)   tput bold ; tput setaf 0 ;;
		ered)     tput bold ; tput setaf 1 ;;
		egreen)   tput bold ; tput setaf 2 ;;
		eyellow)  tput bold ; tput setaf 3 ;;
		eblue)    tput bold ; tput setaf 4 ;;
		emagenta) tput bold ; tput setaf 5 ;;
		ecyan)    tput bold ; tput setaf 6 ;;
		ewhite)   tput bold ; tput setaf 7 ;;

		# underlined colors
		ublack)   set smul unset rmul ; tput setaf 0 ;;
		ured)     set smul unset rmul ; tput setaf 1 ;;
		ugreen)   set smul unset rmul ; tput setaf 2 ;;
		uyellow)  set smul unset rmul ; tput setaf 3 ;;
		ublue)    set smul unset rmul ; tput setaf 4 ;;
		umagenta) set smul unset rmul ; tput setaf 5 ;;
		ucyan)    set smul unset rmul ; tput setaf 6 ;;
		uwhite)   set smul unset rmul ; tput setaf 7 ;;

		# background colors
		bblack)   tput setab 0 ;;
		bred)     tput setab 1 ;;
		bgreen)   tput setab 2 ;;
		byellow)  tput setab 3 ;;
		bblue)    tput setab 4 ;;
		bmagenta) tput setab 5 ;;
		bcyan)    tput setab 6 ;;
		bwhite)   tput setab 7 ;;

		# Defaults
		default)  tput setaf 9 ;;
		bdefault) tput setab 9 ;;
		none)     tput sgr0    ;;
		*)        tput sgr0    #reset
	esac
}
# }}}
# __repo_base_dir {{{
__repo_base_dir() {
	local repo_info rev_parse_exit_code
	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
		--is-bare-repository --is-inside-work-tree \
		--short HEAD 2>/dev/null)"
	rev_parse_exit_code="$?"

	if [ -z "$repo_info" ]; then
		return
	fi

	local git_path git_dir current_dir
	git_path="$(git rev-parse --show-toplevel)"
	git_dir="${git_path##*/}"
	current_dir="${PWD##*/}"

	if [ "$current_dir" != "$git_dir" ]; then
		printf --  "$git_dir"
	fi
}
# }}}
# __repo_state {{{
__repo_state() {
	if command -v __git_ps1 >/dev/null ; then
		GIT_PS1_SHOWDIRTYSTATE=""
		GIT_PS1_SHOWUPSTREAM="auto"
		GIT_PS1_SHOWSTASHSTATE="true"
		GIT_PS1_SHOWUNTRACKEDFILES=""
		GIT_PS1_SHOWCOLORHINTS="true"
		printf "%b" "$(__git_ps1)"
	else
		printf ""
	fi
}
#}}}
# __git_status {{{
# }}}
# }}}
# Interactive shell (prompt,history) settings {{{
# ignore duplicate commands, bg/fg, clear and ls variants
export HISTIGNORE="&:l:l -l:ls:clear:[bf]g:exit"
# adds current working directory (pwd) in the title of xterm (renaming /home to ~).
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~}\007"'
# eof needed 10 times to log out
set -o ignoreeof
# use vim as cli editor
set -o vi
export EDITOR=vim

export PS1="\[$(bput cyan)\]\u\[$(bput yellow)\]\$(__repo_base_dir)\[$(bput magenta)\]\W\[$(bput red)\]\$(__repo_state)\[$(bput none)\]\[$(tput sgr0)\]$ "
# }}}
# Completions {{{
# ssh host completion {{{
if [[ -r "${HOME}/.ssh/known_hosts" ]] ; then
	# ssh hosts from ~/.ssh/known_hosts
	# Thanks to:
	# https://github.com/jqr/dotfiles/blob/master/bash_profile.d/
	_ssh_hosts() {
		grep "Host " "${HOME}/.ssh/config" 2>/dev/null | sed -e "s/Host //g"
		cat "${HOME}/.ssh/known_hosts" | cut -f 1 -d ' ' | \
			sed -e s/,.*//g | uniq | grep -v "\["
	}
	complete -W "$(_ssh_hosts)" ssh
	unset _ssh_hosts
fi
# }}}

#check for bash-completion
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
	source /usr/share/bash-completion/bash_completion
fi

if [[ -d ~/.bash_completion && -r ~/.bash_completion && \
		-x ~/.bash_completion ]]; then
	for i in ~/.bash_completion/*; do
		if [[ -f $i ]]; then
			source $i
		fi
		if [[ -d $i ]]; then
			source $i/*.bash
		fi
	done
fi
# }}}
# Aliases {{{

alias rm="rm -i"
alias l="ls -CF"

case "$_os" in
	Darwin)
		export CLICOLOR=1
		export LSCOLORS=GxFxCxDxBxegedabagaced
		alias grep='grep --color -n'
		alias egrep='egrep --color'
		alias fgrep='fgrep --color'
		#hide gitk errors on osx mountain lion
		alias gitk='gitk 2> /dev/null'
		alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Resources/jsc'
	;;
esac
#}}}
# Colorlize less {{{
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# }}}
# Setup PATH and MANPATH {{{
case "$_os" in
	Darwin)
		__push_path MANPATH /usr/local/man /usr/share/man /usr/local/share/man
		__push_path PATH $HOME/.rbenv/bin $HOME/pear/bin /usr/local/mysql/bin /opt/local/sbin /opt/local/bin /opt/*/current/bin \
			/usr/local/share/python /usr/local/sbin /usr/local/bin /Applications/sqlshell/bin
	;;
esac
case "$_os" in
	OpenBSD)
		# make sure MANPATH isn't set
		unset MANPATH
	;;
	*)
		export MANPATH
	;;
esac
export PATH
cleanup
# }}}
# rbenv {{{
# eval "$(rbenv init -)"
# }}}
# For future reference {{{
# Cli color info
# The color designators are as follows:

# a black
# b red
# c green
# d brown
# e blue
# f magenta
# g cyan
# h light grey
# A bold black, usually shows up as dark grey
# B bold red
# C bold green
# D bold brown, usually shows up as yellow
# E bold blue
# F bold magenta
# G bold cyan
# H bold light grey; looks like bright white
# x default foreground or background

# 1. directory
# 2. symbolic link
# 3. socket
# 4. pipe
# 5. executable
# 6. block special
# 7. character special
# 8. executable with setuid bit set
# 9. executable with setgid bit set
# 10. directory writable to others, with sticky bit
# 11. directory writable to others, without sticky bit
# }}}
