" --------------------------------
" --------------------------------
"  	  NeoVim Settings
"  	      v 0.5
"  	    for windows
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
let g:python3_host_prog='C:\Users\og\scoop\shims\python3.EXE'

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
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  " LSP
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'fannheyward/telescope-coc.nvim'

  " RipGrep
  Plug 'jremmen/vim-ripgrep'

  " syntax highlight
  Plug 'sheerun/vim-polyglot'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

  " Git source controll
  Plug 'tpope/vim-fugitive'

  " COLORS
  Plug 'gruvbox-community/gruvbox'
  Plug 'ryanoasis/vim-devicons'

  Plug 'hoob3rt/lualine.nvim'

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
map <F11> :FloatermNew make run<CR>

map <F2> :call CocAction('format')<CR>

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
nnoremap <space>ff <cmd>lua require'telescope.builtin'.find_files()<cr>
nnoremap <space>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <space>tt <cmd>Telescope builtin<cr>
lua require('telescope_config')

""""
"" coc-settings
""""
lua require('telescope').load_extension('coc')

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <space>ee :Telescope coc workspace_diagnostics<CR>
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gd :Telescope coc definitions<CR>
" nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gi :Telescope coc implementations<CR>
"nmap <silent> gr <Plug>(coc-references)
nmap <silent> gr :Telescope coc references<CR>
nmap <space>r <Plug>(coc-rename)
"nmap <space>qf  <Plug>(coc-codeaction)
nmap <silent> <leader>qf :Telescope coc code_actions<CR>

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if index(['vim', 'help'], &filetype) >= 0
        execute 'help ' . expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
