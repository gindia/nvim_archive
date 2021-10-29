local cmp = require('cmp')

local luasnip = require 'luasnip'

require 'crates'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

cmp.setup {
  snippet = {
    expand = function(args)
      -- You must install `vim-vsnip` if you use the following as-is.
      -- vim.fn['vsnip#anonymous'](args.body)
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

return cmp
