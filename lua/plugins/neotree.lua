return {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        -- '3rd/image.nvim', -- Optional image support in preview window
    },
    keys = {
        { '<leader>nt', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
    },
    config = function()
        require('neo-tree').setup()
    end,
}

