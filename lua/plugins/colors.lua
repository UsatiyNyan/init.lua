return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
        flavour = 'macchiato', -- latte, frappe, macchiato, mocha
        background = { -- :h background
            light = 'latte',
            dark = 'mocha',
        },
        transparent_background = true,
    },
    config = function()
        vim.cmd([[colorscheme catppuccin]])
    end
}

