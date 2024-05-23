return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			require("null-ls").setup({
				debug = true,
				sources = {
					-- go
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.diagnostics.golangci_lint.with({
						extra_args = { "--show-stats=false" },
					}),
					null_ls.builtins.formatting.goimports_reviser.with({
						extra_args = { "-rm-unused" },
					}),

					-- lua
					null_ls.builtins.formatting.stylua,

					-- build files
					null_ls.builtins.diagnostics.buildifier,
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		-- event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("null-ls")
			require("mason-null-ls").setup({
				ensure_installed = nil,
				automatic_installation = true,
			})
		end,
	},
}
