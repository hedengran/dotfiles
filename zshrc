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

alias ls='ls -Gbhp'
chpwd() {
  ls
}


alias ec='emacsclient -n'

alias ev='ec ~/.vimrc'
alias ee='ec ~/.emacs.d/init.el'
alias ez='ec ~/.zshrc'
alias sz='source ~/.zshrc'

############################ git
gl_format_str="--pretty='format:%C(auto,yellow)%h %C(auto,blue)%>(30,trunc)%ad %C(auto,green)%<(20,trunc)%aN%C(auto,reset)%<(80,trunc)%s%C(auto,red)% gD% D'"
alias g='git'
alias gb='git branch'
alias gbv='git branch -v'
alias gbvv='git branch -vv'
alias gco='git checkout'
alias gp='git pull'
alias gl="git log ${gl_format_str}"
alias glg='git lg'
alias gr='git remote'
alias grv='git remote -vv'


upstream_master() {
    branch=$(eval "git rev-parse --abbrev-ref HEAD | awk '{split(\$1, a, \"-\"); print a[1]}'")
    if [ "$branch" = "4.4" ]; then
        echo "dev"
    else
        echo $branch
    fi
}

ghlog() {
    value="neo4j/$(upstream_master)"
    eval "git log ${value}..HEAD ${gl_format_str}"
}

ghdiff() {
    value="neo4j/$(upstream_master)"
    eval "git diff ${value}...HEAD"
}

ghdiffn() {
    value="neo4j/$(upstream_master)"
    eval "git diff --name-only ${value}...HEAD"
}

ghdiffo() {
    value="neo4j/$(upstream_master)"
    echo "Comparing ${curr_branch} to ${upstream_master}"
    eval "git diff --name-only HEAD...${upstream_master}"
}

ghri() {
    value="neo4j/$(upstream_master)"
    commit_n=$(ghlog $value | grep -c "^")
    eval "git rebase -i HEAD~${commit_n}"
}

############################ 
############################ git prompt
source ~/.zsh/zsh-git-prompt/zshrc.sh 
GIT_PROMPT_EXECUTABLE="haskell"

# Set up the prompt 
PROMPT='┌─ ${PWD/#$HOME/~} %{$fg[blue]%}%{$reset_color%}$(git_super_status)
└─ %(?.%{$fg[blue]%}.%{$fg[red]%})%(!.#.λ)%{$reset_color%} '
############################ 
############################ fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# paperwhite
#export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#    --color=fg:#4d4d4c,bg:#eeeeee,hl:#d7005f
#    --color=fg+:#4d4d4c,bg+:#e8e8e8,hl+:#d7005f
#    --color=info:#4271ae,prompt:#8959a8,pointer:#d7005f
#    --color=marker:#4271ae,spinner:#4271ae,header:#4271ae'
############################ 
############################

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/hedengran/.sdkman"
[[ -s "/Users/hedengran/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/hedengran/.sdkman/bin/sdkman-init.sh"
