export ZSH=$HOME/.oh-my-zsh
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

plugins=(git docker conda-zsh-completion)
# export ZSH_THEME="spaceship"
# export ZSH_THEME="robbyrussell_custom"
source $ZSH/oh-my-zsh.sh


# latexmk Seminararbeit.tex -auxdir=./AUX -bibtex -pdflua -pvc

# export NOTES_PATH="~/Documents/Notes/"
export NOTES_PATH="$HOME/Library/CloudStorage/OneDrive-Personal/Notes/Notes"
eval "tmux setenv notes_path $NOTES_PATH"

alias v="nvim"
alias c="cd ~/Documents/Coding/"
alias u="cd ~/Documents/Uni/"
alias nvim_c="cd ~/.dotfiles/nvim/.config/nvim/"
alias notes="cd $NOTES_PATH && nvim $NOTES_PATH"
alias python3="python"


export EDITOR="nvim"
export NVIM_PATH="$HOME/.dotfiles/nvim/.config/nvim/"


# make virtualenv invisible (we see it in oh-my-zsh theme)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

typeset -g KEYTIMEOUT=1

export MAMBA_NO_BANNER=1

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

export PRETTIERD_DEFAULT_CONFIG="$HOME/.prettierrc"

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/mambaforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/mambaforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/mamba.sh" ]; then
    . "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# opam configuration
[[ ! -r /Users/constantinkuehne/.opam/opam-init/init.zsh ]] || source /Users/constantinkuehne/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="/usr/local/bin/code:$PATH"
export MPLBACKEND="module://matplotlib-backend-kitty"
export PYTHONPATH="$HOME/.matplotlib/matplotlib-backend-kitty/:$PYTHONPATH"

export FLINK_HOME="$HOME/flink-1.20.0/"
export PATH="$FLINK_HOME/bin:$PATH"

tmux_conda_precmd() {
  if [[ -n "$TMUX" ]]; then
    tmux setenv conda_env "$CONDA_PREFIX"
  fi
}


precmd_functions+=(tmux_conda_precmd)

if [[ -n "$conda_env" ]]; then
    conda activate "$conda_env"
fi
