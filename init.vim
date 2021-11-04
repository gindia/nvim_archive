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

" remove trailing white space on save
autocmd BufWritePre * :silent! %s/\s\+$//e

" ex mode disable.
map <S-Q> <nop>

" folder nav
nnoremap <silent> <C-n> :Explore<CR>

" copy from cursor to the end of line
nnoremap Y y$

" better undo -> breaks on . , ! ?
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
set lcs=tab:..,space:.
set nolist

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
set nowritebackup
set updatetime=100
set cursorline
set noerrorbells

set nospell

set colorcolumn=100
highlight colorcolumn ctermbg=darkgray

" disable unused providers.
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

set shortmess+=c

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

  " .md preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

  " LSP
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'fannheyward/telescope-coc.nvim'

  " syntax highlight
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'sheerun/vim-polyglot'

  " Git source controll
  Plug 'tpope/vim-fugitive'

  " Colors
  Plug 'projekt0n/github-nvim-theme'

  " Icons
  Plug 'kyazdani42/nvim-web-devicons'

  " staus line.
  Plug 'hoob3rt/lualine.nvim'
  Plug 'nvim-lua/lsp-status.nvim'

  " Floating terminal
  Plug 'voldikss/vim-floaterm'

  " smoos so smoos
  Plug 'karb94/neoscroll.nvim'

call plug#end()

""
" Plugins Settings
""

""""
"" smooth scroll (neoscroll)
""""
lua require('neoscroll').setup()

""""
"" markdown-preview
""""
source $XDG_CONFIG_HOME/nvim/vimsript/markdown_conf.vim

""""
"" floaterm
""""
nnoremap <silent> <leader>' :FloatermToggle<CR>
tnoremap <silent> <leader>' <C-\><C-n>:FloatermToggle<CR>

""""
"" devicons
""""
lua require('nvim-web-devicons')

""""
"" lua-line
""""
lua require('lualine_config')

""""
"" theme
""""
lua require('github-theme').setup( {theme_style = "dimmed", ... } )

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
"" coc
""""

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
let g:coc_snippet_next = '<tab>'

nnoremap <silent> gd         <cmd>Telescope coc definitions<CR>
nnoremap <silent> gi         <cmd>Telescope coc implementations<CR>
nnoremap <silent> <space>ee  <cmd>Telescope coc workspace_diagnostics<CR>
nnoremap <silent> <leader>qf <cmd>Telescope coc code_actions<CR>
nnoremap <silent> gr         <cmd>Telescope coc references<CR>

nmap     <silent> [e <Plug>(coc-diagnostic-prev)
nmap     <silent> ]e <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap     <leader>rr <Plug>(coc-rename)


autocmd CursorHold * silent call CocActionAsync('highlight')

map <F2> <cmd>call CocAction('format')<CR>

"""
" Keybindings
"""
map <F12> <cmd>FloatermNew make<CR>
map <F10> <cmd>FloatermNew make tests<CR>
map <F9>  <cmd>FloatermNew make run<CR>

autocmd FileType c,cpp map <leader>h <cmd>CocCommand clangd.switchSourceHeader<CR>


"""
" copilot
""
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
