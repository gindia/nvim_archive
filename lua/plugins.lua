-----------------------------------------------
-- Plugins.
-- Omar M.Gindia 2021.
-----------------------------------------------
return require'packer'.startup( function()
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'

    -- debs
    use {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    }

    -- colorscheme
    use 'dikiaap/minimalist'
    use 'jnurmine/Zenburn'
    use 'chriskempson/base16-vim'

    -- icons
    use 'kyazdani42/nvim-web-devicons'

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
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'saecki/crates.nvim',
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

end)
