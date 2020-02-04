setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt

# The following lines were added by compinstall
zstyle ':completion:*' matcher-list ''

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups
setopt inc_append_history #this...
setopt share_history #...and this, will make history shared between terminals

unsetopt beep
# End of lines configured by zsh-newuser-install

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# rm * sanity check
setopt RM_STAR_WAIT

#emacs keybindings
bindkey -e

chpwd() {
  ls
}

NEWLINE=$'\n'
PS1='┌─ %n@%M:%~${NEWLINE}└─ λ '
