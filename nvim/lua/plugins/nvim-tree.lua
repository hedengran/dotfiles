return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	keys = {
		{ "<leader>ee", "<cmd>NvimTreeToggle<CR>", mode = { "n" }, desc = "Open NvimTree" },
		{ "<leader>ef", "<cmd>NvimTreeFindFile<CR>", mode = { "n" }, desc = "Locate file in NvimTree" },
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.del("n", "<C-e>", { buffer = bufnr }) -- C-e should be default scroll
			vim.keymap.del("n", "<C-k>", { buffer = bufnr }) -- C-k should navigate windows
		end
		require("nvim-tree").setup({
			-- actions = { open_file = { window_picker = { enable = false } } },
			on_attach = my_on_attach,
			view = {
				preserve_window_proportions = true,
				width = 50,
			},
			-- actions = {
			-- 	open_file = {
			-- 		resize_window = false,
			-- 	},
			-- },
		})
	end,
}
