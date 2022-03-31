-----------------------------------------------
-- Plugins.
-- Omar M.Gindia 2021.
-----------------------------------------------
return require'packer'.startup( function()
    use 'wbthomason/packer.nvim'

    -- debs
    use {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    }

    -- colorscheme
    use 'tomasiser/vim-code-dark'
    use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

    -- syntax
    use 'sheerun/vim-polyglot'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- telescope
     use 'nvim-telescope/telescope.nvim'

    -- lsp
    use 'neovim/nvim-lspconfig'

    -- autocomplete
    use {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('crates').setup()
        end,
    }
    use {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      -- snipets
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    }

    -- git
    use 'tpope/vim-fugitive'

    -- copilot
    use 'github/copilot.vim'

    -- neoscroll for smooth scrolling
    use 'karb94/neoscroll.nvim'

    -- where am I !
    use 'romgrk/nvim-treesitter-context'

    --
    use 'voldikss/vim-floaterm'

end)
