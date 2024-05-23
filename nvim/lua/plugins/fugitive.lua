return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gg", ":Git<CR>")
		vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
		vim.keymap.set("n", "<Leader>gD", ":Gvdiffsplit<CR>")

		-- don't hide git buffers when switching buffers
		-- https://github.com/tpope/vim-fugitive/discussions/1880
		vim.cmd([[autocmd User FugitiveObject setlocal bufhidden=]])
	end,
}
