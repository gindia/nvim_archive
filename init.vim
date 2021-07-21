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
    set guifont="SourceCodePro"
endif

""
" Non Plugins settings.
""

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
set tabstop=2 shiftwidth=2
set softtabstop=2

set autoindent
set smartindent
set shiftround

"set hidden
set noswapfile
set nobackup
set colorcolumn=100
set nowritebackup
set updatetime=100
set cursorline
set noerrorbells

set nospell

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

" use c not cpp
let c_syntax_for_h = 1

""
" Plugins Installs
""
call plug#begin()

  " Kitty term
  Plug 'fladson/vim-kitty'

  " fancy nav
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  " LSP
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " RipGrep
  Plug 'jremmen/vim-ripgrep'

  " syntax highlight
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

"" floaterm
nnoremap <silent> <leader>' :FloatermToggle<CR>
tnoremap <silent> <leader>' <C-\><C-n>:FloatermToggle<CR>


"" theme
set background=dark
colorscheme gruvbox


"" lua-line
lua << EOF
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename', {'g:coc_status', 'bo:filetype'}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF

" Use autocmd to force lightline update.
"autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
"
""""
"" treesitter
""""
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}
EOF

""""
"" coc-settings
""""
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
