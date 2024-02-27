return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local configs = require('nvim-treesitter.configs')
            configs.setup({
                ensure_installed = {
                    'vim',
                    'vimdoc',
                    'query',
                    'c',
                    'cpp',
                    'glsl',
                    'lua',
                    'haskell',
                    'rust',
                    'javascript',
                    'html',
                    'bash',
                    'qmljs',
                    'qmldir',
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                modules = {},
                auto_install = false,
                ignore_install = {},
            })
        end
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
        'peterhoeg/vim-qml',
        ft = { 'qml', 'qmljs', 'qmldir' },
    },
}
