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
-- vim.keymap.set("n", "<leader>mt", vim.cmd("split term://make -C " .. vim.fn.expand("%:h") .. "test"))
vim.keymap.set("n", "<leader>mt", function()
	vim.cmd("split term://make -C" .. vim.fn.expand("%:h") .. " test")
end)

vim.keymap.set("n", "<leader>mm", ':Make -C "%:h"<CR>')
-- globally
vim.keymap.set("n", "<leader>mM", ":Make -C src<CR>")
vim.keymap.set("n", "<leader>mT", ":Make -C src test<CR>")
