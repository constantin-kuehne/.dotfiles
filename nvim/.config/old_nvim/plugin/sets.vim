set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
" set noshowmode
set signcolumn=yes
set isfname+=@-@
" set ls=0
autocmd FileType javascript,typescript,javascriptreact,typescriptreact setlocal ts=2 sts=2 sw=2

set encoding=utf8
set guifont=Fira_Code:h20
set gfw=Fira_Code:h20
set mouse=a

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
set splitbelow

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
set nowrap
