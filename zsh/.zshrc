export ZSH=$HOME/.oh-my-zsh
plugins=(git)

# export ZSH_THEME="spaceship"
# export ZSH_THEME="robbyrussell_custom"
source $ZSH/oh-my-zsh.sh

alias v="nvim"
alias c="cd ~/Documents/Coding/"
alias u="cd ~/Documents/Uni/"
alias code="/usr/local/bin/code"

# make virtualenv invisible (we see it in oh-my-zsh theme)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# export PATH=~/.nvm/versions/node/v16.13.0/bin:$PATH

if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  alias nvm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && nvm'
  alias node='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && node'
  alias npm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && npm'
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# go path setting
export GOPATH=$HOME/go
export GOROOT="/usr/local/opt/go/libexec"
export PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin

# adding custom git commands
zstyle ':completion:*:*:git:*' user-commands change-commits:'change all old commits'
eval "$(starship init zsh)"
