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
HISTSIZE=10000
SAVEHIST=10000
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

alias es='emacsclient -n'

############################ fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# paperwhite
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#4d4d4c,bg:#eeeeee,hl:#d7005f
    --color=fg+:#4d4d4c,bg+:#e8e8e8,hl+:#d7005f
    --color=info:#4271ae,prompt:#8959a8,pointer:#d7005f
    --color=marker:#4271ae,spinner:#4271ae,header:#4271ae'
############################ 

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/hedengran/.sdkman"
[[ -s "/Users/hedengran/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/hedengran/.sdkman/bin/sdkman-init.sh"

