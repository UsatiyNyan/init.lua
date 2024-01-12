local callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local function make_opts(desc)
        return { noremap = true, silent = true, buffer = bufnr, desc = desc }
    end

    local ht = require('haskell-tools')
    -- haskell-language-server relies heavily on codeLenses,
    -- so auto-refresh (see advanced configuration) is enabled by default
    vim.keymap.set('n', '<leader>hcr', vim.lsp.codelens.run, make_opts('Haskell: Codelens run'))
    -- Hoogle search for the type signature of the definition under the cursor
    vim.keymap.set('n', '<leader>hhs', ht.hoogle.hoogle_signature, make_opts('Haskell: Hoogle search'))
    -- Evaluate all code snippets
    vim.keymap.set('n', '<leader>hea', ht.lsp.buf_eval_all, make_opts('Haskell: Evaluate all'))
    -- Toggle a GHCi repl for the current package
    vim.keymap.set('n', '<leader>hgt', ht.repl.toggle, make_opts('Haskell: GHCi toggle'))
    -- Toggle a GHCi repl for the current buffer
    vim.keymap.set('n', '<leader>hgf', function()
        ht.repl.toggle(vim.api.nvim_buf_get_name(0))
    end, make_opts('Haskell: GHCi toggle file'))
    vim.keymap.set('n', '<leader>hgq', ht.repl.quit, make_opts('Haskell: GHCi quit'))
end

local hls_augroup = vim.api.nvim_create_augroup('haskell-lsp', {clear = true})
vim.api.nvim_create_autocmd('FileType', {
    group = hls_augroup,
    pattern = {'haskell'},
    callback = callback,
})

return {
    'mrcjkb/haskell-tools.nvim',
    version = '^3',
    ft = {'haskell', 'lhaskell', 'cabal', 'cabalproject'},
}

