require('telescope').setup{
    defaults = {
        file_sorter    = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix  = '->',
        color_devicons = true,

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

require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
