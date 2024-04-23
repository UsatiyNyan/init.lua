return {
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
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
}
