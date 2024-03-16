return {
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            plugins = {
                marks = true,     -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                spelling = {
                    enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
                presets = {
                    operators = true,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
                    motions = true,      -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true,      -- default bindings on <c-w>
                    nav = true,          -- misc bindings to work with windows
                    z = true,            -- bindings for folds, spelling and others prefixed with z
                    g = true,            -- bindings for prefixed with g
                },
            },
            -- add operators that will trigger motion and text object completion
            -- to enable all native operators, set the preset / operators plugin above
            operators = { gc = 'Comments' },
            icons = {
                breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
                separator = '➜', -- symbol used between a key and it's label
                group = '+', -- symbol prepended to a group
            },
            window = {
                border = 'none',          -- none, single, double, shadow
                position = 'bottom',      -- bottom, top
                margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
                padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            },
        },
    },
    {
        'mbbill/undotree',
        lazy = false,
        keys = {
            { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Undotree' },
        }
    },
    {
        'tpope/vim-fugitive',
        lazy = false,
        keys = {
            { '<leader>gg', vim.cmd.Git, desc = 'Git Status' }
        }
    },
    {
        'zbirenbaum/copilot.lua',
        lazy = false,
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        }
    },
    {
        "zbirenbaum/copilot-cmp",
        lazy = false,
        config = function()
            require("copilot_cmp").setup()
        end,
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        depends = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup()
        end
    }
}
