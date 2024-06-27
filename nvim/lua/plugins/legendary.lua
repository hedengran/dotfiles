return {
	"mrjones2014/legendary.nvim",
	-- since legendary.nvim handles all your keymaps/commands,
	-- its recommended to load legendary.nvim before other plugins
	priority = 10000,
	lazy = false,
	keys = {
		{ "<leader><leader>", ":Legendary<CR>", mode = { "n" }, desc = "Open Legendary" },
	},

	config = function()
		require("legendary").setup({
			extensions = { lazy_nvim = true },
			keymaps = {
				{ "<leader>s", ":SomeCommand<CR>", description = "Non-silent keymap", opts = { silent = true } },
				{ "<BS>", ':let @/ = ""<CR>', description = "Clear search" },
				{ "J", { v = ":m '>+1<CR>gv=gv" }, description = "Move visual selection down" },
				{ "K", { v = ":m '<-2<CR>gv=gv" }, description = "Move visual selection up" },
				{
					"]e",
					function()
						vim.diagnostic.jump({ count = 1 })
					end,
					description = "Jump to the next diagnostic",
				},
				{
					"[e",
					function()
						vim.diagnostic.jump({ count = -1 })
					end,
					description = "Jump to the previous diagnostic",
				},
				{ "<leader>y", [["+y]], description = "Yank to clipboard" },

				{
					"<leader>mt",
					function()
						vim.cmd("split term://make -C" .. vim.fn.expand("%:h") .. " test")
						-- vim.cmd("horizontal resize 15")
						vim.cmd("norm! G") -- jump to bottom to follow output
					end,
					description = "Run 'make test' in directory of current file",
				},
				{ "<leader>mm", ':make -C "%:h"<CR>', description = "Run 'make' in directory of current file" },
			},
			funcs = {
				{
					function()
						vim.cmd('let @+ = expand("%:.")')
					end,
					description = "Yank (copy) current file path to clipboard",
				},
				{
					function()
						vim.diagnostic.open_float()
					end,
					description = "Open diagnostic float",
				},
			},
		})
	end,
}
