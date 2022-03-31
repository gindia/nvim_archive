require('telescope').setup{
    defaults = {
        file_sorter    = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix  = '>>',
        color_devicons = true,

        -- preview = true,
        file_previewer   = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer   = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
        },
    }
}

-- require('telescope').load_extension('fzf')


local opt = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua require"telescope.builtin".find_files()<CR>', opt)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require"telescope.builtin".live_grep()<CR>', opt)
vim.api.nvim_set_keymap('n', '<leader>fw', '<cmd>lua require"telescope.builtin".grep_string()<CR>', opt)
vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>Telescope builtin<CR>', opt)
