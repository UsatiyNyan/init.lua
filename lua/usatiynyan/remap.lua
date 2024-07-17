-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Greatest remaps ever
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move selected up' })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move selected down' })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste and dont lose the paste-buffer' })

-- Greatest remap ever: AsbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'yank!' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Yank!' })

-- Tmux
vim.keymap.set('n', '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'window left' })
vim.keymap.set('n', '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'window down' })
vim.keymap.set('n', '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'window up' })
vim.keymap.set('n', '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'window right' })
