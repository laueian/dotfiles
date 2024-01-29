#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# config
# export BROWSER="googlechrome"

# directories
# export REPOS="$HOME/Repos"
# export GITUSER="mischavandenburg"
# export GHREPOS="$REPOS/github.com/$GITUSER"
# export DOTFILES="$GHREPOS/dotfiles"
# export LAB="$GHREPOS/lab"
# export SCRIPTS="$DOTFILES/scripts"
# export ICLOUD="$HOME/icloud"
# export SECOND_BRAIN="$HOME/second-brain"

# Go related. In general all executables and scripts go in .local/bin
# export GOBIN="$HOME/.local/bin"
# export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
# export GOPATH="$HOME/.local/share/go"
# export GOPATH="$HOME/go/"

# dotnet
# export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~
# function from Arch Wiki, to prevent adding directories multiple times

# set_path(){
#
#     # Check if user id is 1000 or higher
#     [ "$(id -u)" -ge 1000 ] || return
#
#     for i in "$@";
#     do
#         # Check if the directory exists
#         [ -d "$i" ] || continue
#
#         # Check if it is not already in your $PATH.
#         echo "$PATH" | grep -Eq "(^|:)$i(:|$)" && continue
#
#         # Then append it to $PATH and export it
#         export PATH="${PATH}:$i"
#     done
# }
#
# set_path "$HOME"/git/lab/bash "$HOME"/.local/bin

# https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
# PATH="${PATH:+${PATH}:}~/opt/bin"   # appending
# PATH="~/opt/bin${PATH:+:${PATH}}"   # prepending

# Commands also provided by macOS and the commands dir, dircolors, vdir have been installed with the prefix "g".
# If you need to use these commands with their normal names, you can add a "gnubin" directory to your PATH with:
#  PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

# This function is stolen from rwxrob

# clone() {
# 	local repo="$1" user
# 	local repo="${repo#https://github.com/}"
# 	local repo="${repo#git@github.com:}"
# 	if [[ $repo =~ / ]]; then
# 		user="${repo%%/*}"
# 	else
# 		user="$GITUSER"
# 		[[ -z "$user" ]] && user="$USER"
# 	fi
# 	local name="${repo##*/}"
# 	local userd="$REPOS/github.com/$user"
# 	local path="$userd/$name"
# 	[[ -d "$path" ]] && cd "$path" && return
# 	mkdir -p "$userd"
# 	cd "$userd"
# 	echo gh repo clone "$user/$name" -- --recurse-submodule
# 	gh repo clone "$user/$name" -- --recurse-submodule
# 	cd "$name"
# } && export -f clone

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
# SSH Script from arch wiki

# if ! pgrep -u "$USER" ssh-agent >/dev/null; then
# 	ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
# fi
# if [[ ! "$SSH_AUTH_SOCK" ]]; then
# 	source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
# fi

# Only run on Ubuntu

# if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
# 	eval "$(ssh-agent -s)" >/dev/null
# fi

# adding keys was buggy, add them outside of the script for now
# ssh-add -q ~/.ssh/mischa
# ssh-add -q ~/.ssh/mburg
#{
# ssh-add -q ~/.ssh/id_ed25519
# ssh-add -q ~/.ssh/vanoord
#} &>/dev/null

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
# export GIT_PS1_SHOWUPSTREAM="auto git"

if [[ -f "$XDG_CONFIG_HOME/bash/gitprompt.sh" ]]; then
	source "$XDG_CONFIG_HOME/bash/gitprompt.sh"
fi

source ~/.git-prompt.sh
# PROMPT_COMMAND='__git_ps1 "\u@\h:\W" " \n$ "'
# colorized prompt
PROMPT_COMMAND='__git_ps1 "\[\e[33m\]\u\[\e[0m\]@\[\e[34m\]\h\[\e[0m\]:\[\e[35m\]\W\[\e[0m\] ✝️" " \n$ "'

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
# alias vim=nvim

# cd
alias ..="cd .."
alias scripts='cd $SCRIPTS'
# alias rwdot='cd $REPOS/github.com/rwxrob/dot'
alias c="clear"

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias sk='killall ssh-agent && source ~/.zshrc'
alias t='tmux'
alias e='exit'
alias syu='sudo pacman -Syu'

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# fun
alias fishies=asciiquarium

# kubectl
alias k='kubectl'
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

# env variables
export VISUAL=nvim
export EDITOR=nvim

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

if [[ "$OSTYPE" == "darwin"* ]]; then
	echo "“My grace is sufficient for you, for my power is made perfect in weakness.”"

	# brew bash completion
	# [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
	#	source /usr/share/fzf/key-bindings.bash
	#	source /usr/share/fzf/completion.bash
	source "$HOME/.fzf.bash"
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
