return {
    {
        'stevearc/oil.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('oil').setup {
                columns = { 'icon' },
                keymaps = {
                    ['<C-h>'] = false,
                },
                view_options = {
                    show_hidden = true,
                },
            }
            vim.keymap.set('n', '<leader>-', require('oil').toggle_float)
        end,
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
            '3rd/image.nvim', -- Optional image support in preview window
        },
        keys = {
            { '<leader>nt', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
        },
        config = true,
    },
}
