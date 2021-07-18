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

  " Kitty term
  Plug 'fladson/vim-kitty'

  " fancy nav
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  " LSP
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'

  Plug 'folke/lsp-colors.nvim'

  " RipGrep
  Plug 'jremmen/vim-ripgrep'

  " normal syntax highlight
  Plug 'sheerun/vim-polyglot'

  " java syntax
  Plug 'uiiaoo/java-syntax.vim'

  " docs generator
  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

  " Git source controll
  Plug 'tpope/vim-fugitive'

  " COLORS
  Plug 'projekt0n/github-nvim-theme'
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
    lualine_b = {'branch'},
    lualine_c = {'filename'},
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
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

""""
"" LSP
""""

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>qf', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "clangd", "vimls", "bashls", "zls", "hls", "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local sumneko_root_path = "/usr/share/lua-language-server"
local sumneko_binary = "/usr/bin/lua-language-server"


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


EOF

""""
"" LSP_COLORS
"""""
lua require("lsp-colors").setup({})

"""""
"" Auto complete
"""""
lua << EOF

vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

""""
"" coc-settings
""""
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"inoremap <silent><expr> <c-space> coc#refresh()
"
"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [e <Plug>(coc-diagnostic-prev)
"nmap <silent> ]e <Plug>(coc-diagnostic-next)
"
"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"nmap <space>r <Plug>(coc-rename)
"nmap <space>qf  <Plug>(coc-codeaction)
"
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"function! s:show_documentation()
"    if index(['vim', 'help'], &filetype) >= 0
"        execute 'help ' . expand('<cword>')
"    else
"        call CocAction('doHover')
"    endif
"endfunction

"""
" telescope
"""
nnoremap <space>ff <cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ winblend = 10 }))<cr>
nnoremap <space>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
lua require('telescope_config')

set nospell
