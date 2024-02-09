--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    -- nmap('<leader>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
    nmap('<leader>cf', ':Format<CR>', '[C]ode [F]ormat')
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
    clangd = {
        cmd = { 'clangd', '--compile-commands-dir=./build' }
    },
    -- gopls = {},
    -- pyright = {},
    rust_analyzer = {},
    -- tsserver = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
        },
    },
}

return {
    {
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                'clang-format',
                'codelldb',
                'rust-analyzer',
            }
        },
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = 'williamboman/mason.nvim',
        opts = {
            ensure_installed = vim.tbl_keys(servers),
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/nvim-cmp',
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            { 'folke/neodev.nvim', config = true },
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            local mason_lspconfig = require('mason-lspconfig')
            mason_lspconfig.setup_handlers({
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end,
            })
        end,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'VeryLazy',
        opts = function()
            local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
            local null_ls = require('null-ls')

            return {
                sources = {
                    null_ls.builtins.formatting.clang_format,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            }
        end,
    },
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
        dependencies = 'mfussenegger/nvim-dap',
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
        'mrcjkb/rustaceanvim',
        version = '^4',
        ft = 'rust',
        dependencies = 'neovim/nvim-lspconfig',
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            vim.g.rustaceanvim = {
                server = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                },
            }
        end
    },
    {
        'rust-lang/rust.vim',
        ft = 'rust',
        init = function ()
            vim.g.rustfmt_autosave = 1
        end
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        lazy = false,
        config = function()
            require('nvim-dap-virtual-text').setup()
        end
    },
}
