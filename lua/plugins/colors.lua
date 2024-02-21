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
        config = function()
            require('onedark').setup({
                style = 'deep'
            })
            -- vim.cmd.colorscheme 'onedark'
        end
    },
    {
        'nyoom-engineering/oxocarbon.nvim',
        config = function()
            vim.opt.background = 'dark'
            -- vim.cmd.colorscheme 'oxocarbon'
            -- for transparent background:
            -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
            -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
        end
    },
    {
        'rose-pine/neovim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.rose_pine_variant = 'main'
            vim.cmd.colorscheme 'rose-pine'
        end
    },
}

