" --------------------------------
" --------------------------------
"  	  NeoVim Settings
"  	      v 0.5
" --------------------------------
" --------------------------------
""
" GUI settings 'neovide'
""
set mouse=a
if has('win32')
    set guifont="SauceCodePro NF"
else
    " default to Linux
    set guifont="SauceCodePro NF"
endif

""
" Non Plugins settings.
""

"set shell=\"cmd.exe\"\ -f:on\ /k\ \"C:\commands\profile.bat\"

set exrc
set secure
set termguicolors
set splitbelow
set splitright
set autowriteall
set noshowmode
"set nu
"set signcolumn=number
set signcolumn=yes:1
set nohlsearch
set incsearch
set scrolloff=10
set sidescrolloff=10
set scrollback=100000
set nowrap
set expandtab
set smarttab
set tabstop=4 sw=4
set autoindent
set smartindent
set shiftround
set noerrorbells
"set hidden
set noswapfile
set nobackup
set colorcolumn=100
set nowritebackup
set updatetime=100

highlight colorcolumn ctermbg=darkgray
if has('win32')
    let g:python3_host_prog='C:\Program Files\Python39\python.exe'
else
    " default to Linux
endif

let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

set shortmess+=c

" remove trailing white space on save
autocmd BufWritePre * :silent! %s/\s\+$//e

" ex mode disable.
map <S-Q> <nop>

" keymaps
let mapleader=" "

map <leader>w <C-w>

nnoremap <silent> <C-n> :Explore<CR>

nnoremap <silent> <leader>n :bn<CR>
nnoremap <silent> <leader>p :bp<CR>

nnoremap <silent> <leader>bd :%bd<CR>

" use c not cpp
let c_syntax_for_h = 1

""
" Pre Plugins settings
""

"" polyglot
let g:polyglot_disabled = ['java', 'groovy', 'kotlin']


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

    " normal syntax highlight
    Plug 'sheerun/vim-polyglot'

    " lsp based highlight
    Plug 'jackguo380/vim-lsp-cxx-highlight'

    " docs generator
    Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

    " Git source controll
    Plug 'tpope/vim-fugitive'

    " COLORS
    Plug 'gruvbox-community/gruvbox'
    Plug 'ryanoasis/vim-devicons'

    Plug 'itchyny/lightline.vim'

    "floating termguicolors
    Plug 'voldikss/vim-floaterm'

call plug#end()


""
" Plugins Settings
""

"" vim-lsp-cxx-highlight
let g:lsp_cxx_hl_use_text_props = 1


"" floaterm
nnoremap <silent> <leader>' :FloatermToggle<CR>
tnoremap <silent> <leader>' <C-\><C-n>:FloatermToggle<CR>

"" gruvbox
set background=dark
let g:gruvbox_contrast_dark='hard'
"let g:gruvbox_number_column='faded_blue'
colorscheme gruvbox

"" light-line
set laststatus=2
let g:lightline = {
        \ 'colorscheme': 'gruvbox',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'FugitiveHead',
        \   'cocstatus': 'coc#status'
        \ },
        \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
        \ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"""
" coc-settings
"""
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
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <space>r <Plug>(coc-rename)
nmap <space>qf  <Plug>(coc-codeaction)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if index(['vim', 'help'], &filetype) >= 0
        execute 'help ' . expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

"""
" telescope
"""
nnoremap <space>ff <cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ winblend = 10 }))<cr>
nnoremap <space>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
lua require('telescope_config')
