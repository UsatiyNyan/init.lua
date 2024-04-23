return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Add breakpoint at line' })
            vim.keymap.set('n', '<leader>dr', '<cmd> DapContinue <CR>', { desc = 'Start or continue the debugger' })
            vim.keymap.set('n', '<leader>dus', function()
                    local widgets = require('dap.ui.widgets')
                    local sidebar = widgets.sidebar(widgets.scopes)
                    sidebar.open()
                end,
                { desc = 'Open debugging sidebar' })
        end
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        event = 'VeryLazy',
        dependencies = {
            'williamboman/mason.nvim',
            'mfussenegger/nvim-dap',
        },
        opts = {
            handlers = {}
        },
    },
    {
        'rcarriga/nvim-dap-ui',
        event = 'VeryLazy',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup()
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end
        end
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        lazy = false,
        config = function(opts)
            require('nvim-dap-virtual-text').setup(opts)
        end
    },
}

