-----------------------------------------------
-- V0.6 Neovim configs for windog 10.
-- Omar M.Gindia 2021.
-----------------------------------------------
-- sets powershell
--vim.opt.shell        = 'pwsh'
--vim.opt.shellcmdflag = '-NoLogo'
--vim.opt.shellredir   = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
--vim.opt.shellpipe    = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
--vim.opt.shellquote   = ''
--vim.opt.shellxquote  = ''

local cmd = vim.cmd -- exec commands - cmd('cmd')
local map = vim.api.nvim_set_keymap

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- opt.makeprg = 'build'
map('', '<F12>', '<cmd>make! | copen<CR>', { noremap = true, silent = true })
map('', '<F9>', '<cmd>make! run<CR>', { noremap = true, silent = true })

vim.g.mapleader = " "
map('', '<leader>w', '<C-w>', {noremap=true})

cmd("set keywordprg=")
map('', 'K', '<NOP>', {noremap=true})
map('', '<S-Q>', '<NOP>', {noremap=true}) -- disable ex mode

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
cmd("set colorcolumn=100")
cmd("set cursorline")
cmd("set nospell")
cmd("set incsearch")

cmd("set autowriteall");
cmd("set noshowmode")
cmd("set updatetime=100")
cmd("set shortmess+=c")

--cmd("set signcolumn=yes:1")
cmd("set signcolumn=number")
cmd("set number")

require'plugins'

cmd"colorscheme minimalist"

require'lsp_config'
require'telescope_config'
require'treesitter_config'

cmd('autocmd FileType c map <leader>h <cmd>ClangdSwitchSourceHeader<CR>')
cmd('imap <silent><script><expr> <C-J> copilot#Accept("\\<CR>")')
vim.g.copilot_no_tab_map = true
