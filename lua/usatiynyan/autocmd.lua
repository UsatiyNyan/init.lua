-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.cmd('autocmd BufRead,BufNewFile *.vert set filetype=glsl')
vim.cmd('autocmd BufRead,BufNewFile *.frag set filetype=glsl')
