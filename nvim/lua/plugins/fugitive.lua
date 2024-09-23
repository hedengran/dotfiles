return {
	{
		"tpope/vim-fugitive",
		lazy = false,
		keys = {
			{ "<leader>gg", ":Git<CR>", mode = { "n" }, desc = "Open git" },
			{ "<leader>gb", ":Git blame<CR>", mode = { "n" }, desc = "Git blame" },
			{ "<Leader>gD", ":Gvdiffsplit<CR>", mode = { "n" }, desc = "Open git diff in split view" },
			{
				"<Leader>go",
				":Gvsplit origin/main:%<CR>",
				mode = { "n" },
				desc = "Open unedited file from origin/main in split",
			},
		},
		config = function()
			-- don't hide git buffers when switching buffers
			-- https://github.com/tpope/vim-fugitive/discussions/1880
			vim.cmd([[autocmd User FugitiveObject setlocal bufhidden=]])
		end,
	},
	{
		"shumphrey/fugitive-gitlab.vim",
		lazy = false,
		config = function()
			vim.g["fugitive_gitlab_domains"] = { "https://gitlab.evroc.dev/" }
		end,
	},
}
