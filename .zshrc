export DOTFILES=$HOME/code/dotfiles/
export ZSH=$DOTFILES/oh-my-zsh
export DISABLE_AUTO_UPDATE="true"
export ZSH_THEME="prose"

setopt INC_APPEND_HISTORY
setopt prompt_subst
unsetopt correct_all

plugins=(command-coloring git)
source $ZSH/oh-my-zsh.sh


# Load the Bash configuration (lazy boy!)
. ~/.bash_profile

# Colorful world
autoload -U colors && colors

function hg_prompt_info {
    hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo ' (p:'`basename $VIRTUAL_ENV`')'
}

function rvm_info {
    if [[ -a ~/.rvm/bin/rvm-prompt ]] then
        inf=$(~/.rvm/bin/rvm-prompt g| awk '{sub(/@/,"");print}')
        if [[ $inf != "" ]] then
            echo " (r:$inf)"
        fi
    fi
}

function user_name {
    if [[ `whoami` -ne 'thomas' ]] then
        echo "%{$fg[magenta]%}%n%{$reset_color%} | "
    fi
}

# Nicer prompt
if [[ "$SSH_CLIENT" == "" ]]; then
    HOSTNAME=""
else
    HOSTNAME="%{$fg[green]%}%m%{$reset_color%} | "
fi

export PROMPT='$HOSTNAME$(user_name)%{$fg[cyan]%}%~%{$reset_color%} > '
export RPROMPT='%{$fg[yellow]%}$(virtualenv_info)$(rvm_info)%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

export HISTFILE=$HOME/.zhistory
setopt APPEND_HISTORY
export HISTSIZE=1200
export SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
unsetopt SHARE_HISTORY

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

alias heroku logs='nocorrect heroku logs'
