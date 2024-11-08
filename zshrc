if [[ ! -f ~/.antigen.zsh ]]; then
  curl -L git.io/antigen > ~/.antigen.zsh
fi
source ~/.antigen.zsh

antigen bundle woefe/git-prompt.zsh

antigen bundle zsh-users/zsh-autosuggestions 
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6f7275"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"
# Don't autosuggest cd from history, I want only real suggestions
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd*"
# Don't autosuggest cd immediately, require at least one first letter of path
ZSH_AUTOSUGGEST_COMPLETION_IGNORE="cd |cd|cd */(a*/)#|cd *."

antigen bundle joshskidmore/zsh-fzf-history-search
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0

antigen bundle wfxr/forgit

# This plugin must be last
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

################################################################################
################################################################################
################################################################################
### My config
################################################################################
################################################################################
################################################################################

setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt

# The following lines were added by compinstall
zstyle ':completion:*' matcher-list ''

# Tab completion
autoload -Uz compinit; compinit

unsetopt beep

# rm * sanity check
setopt RM_STAR_WAIT

alias ls='ls -Gbhp'
chpwd() {
  ls -Gbhp
}

# cd to git root
cdg() {
	cd `git rev-parse --show-toplevel`
} 

# Do not require a leading '.' in a filename to be matched explicitly
setopt globdots

# https://direnv.net/
# Support .envrc file for directory-dependent env vars
eval "$(direnv hook zsh)"

################################################################################
# History
################################################################################

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_all_dups
setopt inc_append_history #this...
setopt share_history #...and this, will make history shared between terminals

# Remove superfluous blanks from each command line being added to the history
# list
setopt histreduceblanks

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

################################################################################
# Shortcuts
################################################################################

alias vim='nvim'

alias ev='vim ~/.config/nvim/init.lua'
alias ez='vim ~/.zshrc'
alias sz='source ~/.zshrc'

alias tmux='TERM=xterm-256color tmux'
alias tmx='tmux new -As0'
alias vm='autossh -t -M 20000 vm-tmux'
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'

################################################################################
# Git
################################################################################

gl_format_str="--pretty='format:%C(auto,yellow)%h %C(auto,blue)%>(30,trunc)%ad %C(auto,green)%<(20,trunc)%aN%C(auto,reset)%<(80,trunc)%s%C(auto,red)% gD% D'"
alias gb='git branch -vv'
alias gs='git status'
# alias gc='git commit'
alias gco='git checkout'
# alias gp='git pull'
alias gl="git log --topo-order ${gl_format_str}"
alias glg='git lg'
alias gr='git remote -vv'
alias gwl='git worktree list -vv'

function gwa {
  # Check if a branch name is provided as an argument
  if [ -z "$1" ]; then
    echo "Error: No branch name provided."
    return 1
  fi

  branch_name="$1"

  git fetch

  worktree_dir="../$branch_name"

  # Create the worktree with the given branch name
  git worktree add "$worktree_dir" -b "ghedengran/$branch_name" HEAD --no-track 

  # Provide feedback to the user
  if [ $? -eq 0 ]; then
    echo "Worktree '$branch_name' created at '$worktree_dir'."
  else
    echo "Failed to create worktree."
  fi
}

################################################################################
# Prompt
################################################################################

ZSH_GIT_PROMPT_SHOW_UPSTREAM=full
# ZSH_THEME_GIT_PROMPT_SHOW_UPSTREAM=1
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[blue]%} -> "
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX=""
RPROMPT=''

# %D{%d/%m/%y %H:%M:%S}
# Set up the prompt 
PROMPT='┌─ (%D{%H:%M:%S}) %{$fg[green]%}%m%{$reset_color%} ${PWD/#$HOME/~}%{$fg[blue]%}%{$reset_color%} $(gitprompt)
└─ %(?.%{$fg[blue]%}.%{$fg[red]%})%(!.#.$)%{$reset_color%} '

################################################################################
# Fuzzy-find
################################################################################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Nicer colors for fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c8d3f5,bg:#222436,hl:#ff966c \
--color=fg+:#c8d3f5,bg+:#2f334d,hl+:#ff966c \
--color=info:#82aaff,prompt:#86e1fc,pointer:#86e1fc \
--color=marker:#c3e88d,spinner:#c3e88d,header:#c3e88d"

################################################################################
# Kubernetes
################################################################################

alias k='kubectl'

# Kubectl krew plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
[[ /usr/local/bin/minikube ]] && source <(minikube completion zsh)


evid() {
	local pane_capture=$(tmux capture-pane -J -p)
	local iid_regex='[a-z]{2,3}-[a-z0-9]{16}'
	local iid=$(echo $pane_capture | grep -oE ".*$iid_regex.*" | fzf-tmux -d10 --multi --layout=reverse | awk "match(\$0, /$iid_regex/) {print substr(\$0, RSTART, RLENGTH)}")
	LBUFFER+=$iid
} 

# zle -N -M evid
zle -N evid

bindkey ^t evid

################################################################################
################################################################################
################################################################################
# END
################################################################################
################################################################################
################################################################################

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# use docker-machine default for docker client
# eval "$(docker-machine env default)"

# pnpm
export PNPM_HOME="/home/hedengran/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
