" --------------------------------
" --------------------------------
"  	      v 0.5
"  	  NeoVim Settings
"  	    for linux
" --------------------------------
" --------------------------------
""
" Non Plugins settings.
""
let mapleader=" "

" window
map <leader>w <C-w>

nnoremap <silent> <C-n> :Explore<CR>
" copy from cursor to the end of line
nnoremap Y y$

" better undo
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" move text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" inoremap <C-j> <esc>:m .+1<CR>==
" inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

set mouse=a

set exrc
set secure
set termguicolors
set splitbelow
set splitright
set autowriteall
set noshowmode
set signcolumn=yes:1
set nohlsearch
set incsearch
set scrolloff=10
set sidescrolloff=10
set scrollback=100000
set nowrap

"" tabs
set expandtab
set smarttab
set tabstop=2 shiftwidth=2 "sw:2
set softtabstop=2

set autoindent
set smartindent
set shiftround

set hidden
set noswapfile
set nobackup
set colorcolumn=100
set nowritebackup
set updatetime=100
set cursorline
set noerrorbells

set nospell

highlight colorcolumn ctermbg=darkgray

" py2
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

set shortmess+=c

" remove trailing white space on save
autocmd BufWritePre * :silent! %s/\s\+$//e

" ex mode disable.
map <S-Q> <nop>

" keymaps

" use c not cpp for .h files
let c_syntax_for_h = 1

" termdebug
let g:termdebug_wide=1

""
" Plugins Installs
""
call plug#begin()
  " fancy nav
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

  " LSP
  Plug 'neovim/nvim-lspconfig'

  " lsp completion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-nvim-lsp'

  " lsp snip
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'L3MON4D3/LuaSnip'

  " RipGrep
  Plug 'jremmen/vim-ripgrep'

  " syntax highlight
  Plug 'sheerun/vim-polyglot'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

  " Git source controll
  Plug 'tpope/vim-fugitive'

  " COLORS
  Plug 'gruvbox-community/gruvbox'
  "Plug 'ryanoasis/vim-devicons'
  Plug 'kyazdani42/nvim-web-devicons'

  Plug 'hoob3rt/lualine.nvim'
  Plug 'nvim-lua/lsp-status.nvim'

  "floating termguicolors
  Plug 'voldikss/vim-floaterm'

call plug#end()

""
" Plugins Settings
""

""""
"" floaterm
""""
nnoremap <silent> <leader>' :FloatermToggle<CR>
tnoremap <silent> <leader>' <C-\><C-n>:FloatermToggle<CR>

map <F12> :FloatermNew make<CR>
map <F9> :FloatermNew make run<CR>

""""
"" devicons
""""
lua require('nvim-web-devicons')

""""
"" theme
""""
set background=dark
colorscheme gruvbox

""""
"" lua-line
""""
lua require('lualine_config')

""""
"" treesitter
""""
lua require('treesitter_config')

"""
" telescope
"""
"nnoremap <space>ff <cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ winblend = 10 }))<cr>
nnoremap <leader>ff <cmd>lua require'telescope.builtin'.find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>tt <cmd>Telescope builtin<cr>
lua require('telescope_config')

""""
"" nvimlsp
""""
lua require('lsp_lua_config')
lua require('lsp_config')

lua require('cmp_config')
lua require('luasnip')

nnoremap <silent> gd         <cmd>Telescope lsp_definitions<CR>
nnoremap <silent> gi         <cmd>Telescope lsp_implementations<CR>
nnoremap <silent> <space>ee  <cmd>Telescope lsp_document_diagnostics<CR>
nnoremap <silent> <leader>qf <cmd>Telescope lsp_code_actions<CR>
nnoremap <silent> gr         <cmd>Telescope lsp_references<CR>
