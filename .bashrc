#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# directories
export DOTFILES="$HOME/dotfiles"
export SECOND_BRAIN="$HOME/second-brain"
export WORK_BRAIN="$HOME/work-brain"
export SCRIPTS="$DOTFILES/scripts"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

PATH="${PATH:+${PATH}:}"$SCRIPTS":"$HOME"/.local/bin" # appending

export HOMEBREW_PREFIX=/usr/local/
export LDAP_USERNAME=ilaue
export VAULT_ADDR=https://vault.ihs.demonware.net:8200

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
# export GIT_PS1_SHOWUPSTREAM="auto git"

if [ -f $XDG_CONFIG_HOME/bash/git-prompt.sh ]; then
	source "$XDG_CONFIG_HOME/bash/git-prompt.sh"
fi

# PROMPT_COMMAND='__git_ps1 "\u@\h:\W" " \n$ "'
# colorized prompt
PROMPT_COMMAND='__git_ps1 "\[\e[33m\]\u\[\e[0m\]@\[\e[34m\]\h\[\e[0m\]:\[\e[35m\]\W\[\e[0m\] ✝️" " \n$ "'

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v="nvim ."

alias reload='source ~/.bashrc'

# cd
alias ..="cd .."
alias scripts='cd $SCRIPTS'
alias c="clear"

alias cdseg='cd ~/activ/python-dynamic-segmentation'
alias cdsegdeploy='cd ~/activ/python-dynamic-segmentation-deploy'

alias cdabt='cd ~/activ/abtesting'
alias cdabtdeploy='cd ~/activ/abtesting-deploy'

alias cdsb='cd $SECOND_BRAIN'
alias cdwb='cd $WORK_BRAIN'

# docker
alias dexec='(){docker exec -it $1 /bin/bash;}'
alias vlogin="vault login --method=ldap username=$LDAP_USERNAME"
alias history="history 1"
alias gs="git status"
alias gistv='gh gist list --limit 30 | fzf --ansi --preview "gh gist view {1}" --preview-window=top:30 --height=95% | awk '\''{print $1}'\'' | xargs -I {} gh gist view {} | vim -'
alias gistvweb='gh gist list --limit 30 | fzf --ansi --preview "gh gist view {1}" --preview-window=top:30 --height=95% | awk '\''{print $1}'\'' | xargs -I {} gh gist view {} -w'

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias sk='killall ssh-agent && source ~/.bashrc'
alias t='tmux'
alias e='exit'

# git
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
else
	source "$HOME/.fzf.bash"
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

