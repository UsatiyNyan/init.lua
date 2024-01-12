return {
    { 'folke/which-key.nvim', lazy = false },
    {
        'mbbill/undotree', lazy = false, keys = {
            { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Undotree' },
        }
    },
    {
        'tpope/vim-fugitive', lazy = false, keys = {
            { '<leader>gg', vim.cmd.Git, desc = 'Git Status' }
        }
    },
    { 'github/copilot.vim', lazy = false }
}

