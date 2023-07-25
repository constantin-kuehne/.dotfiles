export ZSH=$HOME/.oh-my-zsh
plugins=(git docker virtualenv conda-zsh-completion)

source $ZSH/oh-my-zsh.sh

export NOTES_PATH="/mnt/c/Users/Kuehne/Desktop/Projects/notes/"
eval "tmux setenv notes_path $NOTES_PATH"

alias v="nvim"
alias c="cd ~/Documents/Coding/"
alias u="cd ~/Documents/Uni/"
alias nvim_c="cd ~/.dotfiles/nvim/.config/nvim/"
alias mysudo='sudo -E env "PATH=$PATH"'
alias explorer="explorer.exe"
alias chrome="'/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'"
alias notes="cd $NOTES_PATH && glow ."
alias projects="cd /home/kuehne/projects/"

typeset -g KEYTIMEOUT=1

export EDITOR="nvim"
export NVIM_PATH="$HOME/.dotfiles/nvim/.config/nvim/"

export PRETTIERD_DEFAULT_CONFIG="$HOME/.prettierrc"

export projects="/home/kuehne/projects/"

# go path setting
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin

export PATH=$PATH:$HOME/personal/bin/
export PATH=$PATH:$HOME/personal/bin/sumneko_lua/bin/
export PATH=$PATH:$HOME/personal/bin/ltex-ls-16.0.0/bin/
export PATH=$PATH:$HOME/personal/bin/mambaforge/bin/
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/texlive/2023/bin/x86_64-linux/

export MAMBA_NO_BANNER=1

export PROJECT_DIR=/mnt/c/Users/Kuehne/Desktop/Projects/

# adding custom git commands
zstyle ':completion:*:*:git:*' user-commands change-commits:'change all old commits'
zstyle ':completion:*:*:git:*' user-commands add-worktree:'add a worktree by only specifying the remote branch name'
zstyle ':completion:*:*:git:*:add-worktree:' user-commands wow:'wow'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kuehne/personal/bin/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kuehne/personal/bin/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/kuehne/personal/bin/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/kuehne/personal/bin/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/kuehne/personal/bin/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/kuehne/personal/bin/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# make virtualenv invisible (we see it in oh-my-zsh theme)
export VIRTUAL_ENV_DISABLE_PROMPT=1


bindkey -v
bindkey "^R" history-incremental-search-backward
eval "$(starship init zsh)"
autoload -U compinit && compinit

# latexmk Seminararbeit.tex -auxdir=./AUX -bibtex -pdflua -pvc
PATH="/home/kuehne/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/kuehne/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/kuehne/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/kuehne/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/kuehne/perl5"; export PERL_MM_OPT;
