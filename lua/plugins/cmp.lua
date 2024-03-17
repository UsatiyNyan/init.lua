return {
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',

            'kirasok/cmp-hledger',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            -- require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup({})

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-n>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            cmp.complete()
                        end
                    end),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-y>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },
                },
                sources = {
                    { name = 'copilot' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'crates' },
                    { name = 'hledger' },
                },
            }
        end,
    },
    {
        'saecki/crates.nvim',
        ft = { 'toml' },
        dependencies = 'hrsh7th/nvim-cmp',
        config = function(_, opts)
            local crates = require('crates')
            crates.setup(opts)
            crates.show()
            vim.keymap.set('n', '<leader>rcu', function()
                require('crates').upgrade_all_crates()
            end, { desc = 'Rust: update crates' })
        end,
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
    },
    {
        'kirasok/cmp-hledger',
        ft = ".journal"
    }
}
