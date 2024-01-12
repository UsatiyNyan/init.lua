return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        opts = {
            flavour = 'macchiato', -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = 'latte',
                dark = 'mocha',
            },
            transparent_background = true,
        },
    },
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('onedark').setup({
                style = 'deep'
            })
            vim.cmd([[colorscheme onedark]])
        end
    }
}

