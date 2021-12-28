-----------------------------------------------
-- V0.6 Neovim configs for windog 10.
-- Omar M.Gindia 2021.
-----------------------------------------------

local cmd = vim.cmd -- exec commands - cmd('cmd')
local map = vim.api.nvim_set_keymap

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

map('', '<F12>', '<cmd>wa<CR><C-w>w <cmd>term build<CR><C-w>w', { noremap = true, silent = true })
map('', '<F9>', '<C-w>w <cmd>term run<CR> <C-w>w', { noremap = true, silent = true })

vim.g.mapleader = " "
map('', '<leader>w', '<C-w>', {noremap=true})

map('', '<C-n>', '<cmd>Explore<CR>', { noremap = true, silent = true })

vim.g.makeprg = 'build'

cmd("set keywordprg=")
map('', 'K', '<NOP>', {noremap=true})
map('', '<S-Q>', '<NOP>', {noremap=true}) -- disable ex mode

-- use C not CPlusPlus for header files
cmd("let c_syntax_for_h=1")

-- remove trailing whitespace
cmd("autocmd BufWritePre * :silent! %s/\\s\\+$//e")

-- nav impovements
map('n', 'Y', 'y$', {noremap=true})

map('i', ',', ',<c-g>u', {noremap=true})
map('i', '.', '.<c-g>u', {noremap=true})
map('i', '!', '!<c-g>u', {noremap=true})
map('i', '?', '?<c-g>u', {noremap=true})
map('n', '<leader>j', "<cmd>m .+1<CR>==", {noremap=true})
map('n', '<leader>k', "<cmd>m .-2<CR>==", {noremap=true})

-- disable numbers in terminal
cmd('autocmd TermOpen * setlocal nonumber')
cmd('autocmd TermOpen * setlocal nospell')

-- opts
cmd("set mouse=a")

vim.opt.exrc   = true
vim.opt.secure = true

cmd("set termguicolors")
cmd("set splitbelow")
cmd("set splitright")
cmd("set nohlsearch")
cmd("set scrolloff=10")
cmd("set sidescrolloff=10")
cmd("set scrollback=100000")
cmd("set nowrap")
cmd("set expandtab")
cmd("set smarttab")
cmd("set tabstop=2 shiftwidth=2")
cmd("set softtabstop=2")
cmd("set autoindent")
cmd("set smartindent")
cmd("set shiftround")
cmd("set hidden")
cmd("set noswapfile")
cmd("set nobackup")
cmd("set nowritebackup")
cmd("set nospell")
cmd("set incsearch")

cmd("set colorcolumn=100")

cmd("set cursorline")
cmd("set cursorcolumn")


cmd("set autowriteall");
cmd("set noshowmode")
cmd("set updatetime=100")
cmd("set shortmess+=c")

cmd("set signcolumn=number")
cmd("set number")

require'plugins'

cmd"colorscheme codedark"
-- cmd"set background=dark"
-- cmd"let g:gruvbox_contrast_dark='hard'"
-- cmd"colorscheme gruvbox"

require'lsp_config'
cmd('autocmd FileType c map <leader>h <cmd>ClangdSwitchSourceHeader<CR>')

require'telescope_config'
require'treesitter_config'

-- copilot
cmd('imap <silent><script><expr> <C-J> copilot#Accept("\\<CR>")')
vim.g.copilot_no_tab_map = true
cmd("let g:copilot_filetypes = { '*': v:false, }")

-- neoscoll
require'neoscroll'.setup()

--- --- ---
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
    max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
        },
        -- Example for a specific filetype.
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        --   rust = {
        --       'impl_item',
        --   },
    },
}
