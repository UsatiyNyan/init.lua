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
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    'nvim-treesitter/nvim-treesitter-context'
}

