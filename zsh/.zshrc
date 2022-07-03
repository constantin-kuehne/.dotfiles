export ZSH=$HOME/.oh-my-zsh
plugins=(git)
# export ZSH_THEME="spaceship"
# export ZSH_THEME="robbyrussell_custom"
source $ZSH/oh-my-zsh.sh

alias v="nvim"
alias c="cd ~/Documents/Coding/"
alias u="cd ~/Documents/Uni/"
alias nvim_c="cd ~/.dotfiles/nvim/.config/nvim/"

# make virtualenv invisible (we see it in oh-my-zsh theme)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

typeset -g KEYTIMEOUT=1

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# if [ -s "$HOME/.nvm/nvm.sh" ]; then
#   export NVM_DIR="$HOME/.nvm"
#   [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
#   alias nvm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && nvm'
#   alias node='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && node'
#   alias npm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && npm'
# fi

export EDITOR="nvim"
export NVIM_PATH="$HOME/.dotfiles/nvim/.config/nvim/"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# go path setting
export GOPATH=$HOME/go
export GOROOT="/opt/homebrew/opt/go/libexec/"
export PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin

# adding custom git commands
zstyle ':completion:*:*:git:*' user-commands change-commits:'change all old commits'
zstyle ':completion:*:*:git:*' user-commands add-worktree:'add a worktree by only specifying the remote branch name'
zstyle ':completion:*:*:git:*:add-worktree:' user-commands wow:'wow'

bindkey -v
bindkey "^R" history-incremental-search-backward
eval "$(starship init zsh)"
