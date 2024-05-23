-- Keybindings
local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

keymap("n", "<BS>", ':let @/ = ""<CR>', default_opts)

keymap("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", default_opts)
keymap("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", default_opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "]e", vim.diagnostic.goto_next)
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- make
-- in directory of file in current buffer
vim.keymap.set("n", "<leader>mm", ':!make -C "%:h"<CR>')
vim.keymap.set("n", "<leader>mt", ':!make -C "%:h" test<CR>')
-- globally
vim.keymap.set("n", "<leader>mM", ":!make -C src<CR>")
vim.keymap.set("n", "<leader>mT", ":!make -C src test<CR>")
