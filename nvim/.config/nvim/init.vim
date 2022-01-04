set path+=**

set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/* 
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

call plug#begin()

" gruvbox theme
Plug 'morhetz/gruvbox'

" airline and airline themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'

" Telescope + requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Telescope UI for nvim-dap
Plug 'nvim-telescope/telescope-dap.nvim'

" Language server support
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Add auto format
Plug 'sbdchd/neoformat'

" Git for neovim
Plug 'tpope/vim-fugitive'

" Jupyter Notebooks in neovim
Plug 'untitled-ai/jupyter_ascending.vim'

" Nerdtree file explorer
" Plug 'preservim/nerdtree'

" Git Nerdtree
" Plug 'Xuyuanp/nerdtree-git-plugin'

" ipy in vim
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" Telescope Neoclip (search through clipboard)
Plug 'AckslD/nvim-neoclip.lua'

" TODO plugin
Plug 'folke/todo-comments.nvim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Harpoon (fast file travelling) by ThePrimeagen
Plug 'ThePrimeagen/harpoon'

" requires
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Nertree file icons (always needs to be last)
" Plug 'ryanoasis/vim-devicons'

call plug#end()

syntax on

colorscheme gruvbox

hi Normal guibg=NONE ctermbg=NONE

let mapleader = " " " map leader to Space

let g:airline_powerline_fonts = 1
let g:airline_theme='base16_gruvbox_dark_hard'
" let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_stl_path_style = 'short'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved' 

" let NERDTreeShowHidden = 1
" let NERDTreeMinimalUI = 1
" let g:NERDTreeQuitOnOpen = 1
let g:nvim_tree_quit_on_open = 1

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

xnoremap <leader>p "_dP
nnoremap <leader>p "+p
nnoremap <leader>P "+P

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <silent> <leader>th :new<CR>:term<CR><C-W>10-<CR>

" Make esc leave terminal mode
tnoremap <Esc> <C-\><C-n>

lua require("const")
lua require'nvim-treesitter.configs'.setup { indent = { enable = true }, highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

" augroup fmt
"   autocmd!
"   au BufWritePre * try | undojoin | silent Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
" augroup END

augroup fmt
  autocmd!
  autocmd BufWritePre * silent! undojoin | Neoformat
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 150})
augroup END

augroup terminal_settings
    autocmd!

    autocmd BufLeave term://* stopinsert

    " Ignore various filetypes as those will close terminal automatically
    " Ignore fzf, ranger, coc
    autocmd TermClose term://*
          \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
          \   call nvim_input('<CR>')  |
          \ endif
augroup END

function! JW_on_term_exit(a, b)
    normal q!
endfunction

nnoremap <silent> <Bslash> :below call term_start('env TERM=st-256color zsh', { 'exit_cb': 'JW_on_term_exit', 'term_name': 'zsh', 'norestore': 1 })<Return>
