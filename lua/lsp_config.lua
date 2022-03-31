-----------------------------------------------
-- LSP Configs
-- Omar M.Gindia 2021.
-----------------------------------------------

-- a list of language servers to enable
local servers = {
  'clangd',
  -- 'rust_analyzer',
  -- 'csharp_ls',
  -- 'jdtls',
  -- 'lemminx',
  -- 'cmake',
  -- 'jsonls',
  -- 'html',
  -- 'cssls',
  -- 'pyright',
  -- 'tsserver',
  -- 'gopls',
  -- 'zls',
}

local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '<space>qf', '<cmd>Telescope lsp_code_actions<CR>', opts)
  buf_set_keymap('n', '<space>ee', '<cmd>Telescope diagnostics<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  vim.cmd [[ command! Cleanc :silent %s/\r//g ]]
end

local lsp_config = require('lspconfig')
for _, lsp in ipairs(servers) do
  lsp_config[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- man stands for manual
local sumneko_binary = "C:\\Users\\omerg\\lua_lsp\\lua-language-server-2.6.6-win32-x64\\bin\\lua-language-server"
local sumneko_root_path = "C:\\Users\\omerg\\lua_lsp\\lua-language-server-2.6.6-win32-x64"

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lsp_config.sumneko_lua.setup {
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  on_attach = on_attach,
  --capabilities = capabilities,
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
        globals = { 'vim', 'use' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


--disable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
       virtual_text = false,
       signs = false,
       update_in_insert = false,
       underline = false,
    }
)

-- disable diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--        virtual_text = false,
--        signs = false,
--        update_in_insert = false,
--        underline = false,
--     }
-- )

--------------------------------------------------------------------------------------------------
--- Auto complete
--------------------------------------------------------------------------------------------------
local cmp = require('cmp')

local luasnip = require 'luasnip'

-- require 'crates'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },

  -- You can set mapping if you want.
  mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- You should specify your *installed* sources.
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip'  },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'crates' },
  },
}
