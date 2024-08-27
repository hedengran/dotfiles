return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },
	-- telescope-file-browser
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file" },
			{
				"<leader>fg",
				":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				desc = "Live grep",
			},
			-- {
			-- 	"<leader>fG",
			-- 	":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
			-- 	desc = "Live grep",
			-- }, -ig **/folder/** "word"
			-- { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find current buffer" },
			{ "gr", "<cmd>Telescope lsp_references show_line=false<cr>", desc = "" },
			{ "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "" },

			--{"<esc>", "<cmd>actions.close", mode = "i", desc = "Close Telescope"},
		},
		config = function()
			local lga_actions = require("telescope-live-grep-args.actions")
			require("telescope").setup({
				pickers = {
					buffers = {
						show_all_buffers = true,
						ignore_current_buffer = true,
						sort_mru = true,
						mappings = {
							i = {
								["<c-d>"] = "delete_buffer",
							},
						},
						theme = "ivy",
					},
					current_buffer_fuzzy_find = {
						theme = "ivy",
						file_ignore_patterns = {}, -- override defaults
					},
					lsp_references = {
						include_declaration = false,
					},
				},
				extensions = {
					fzf = {
						fuzzy = false, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								-- ["<C-i>"] = function()
								-- 	local pwd = vim.fn.expand("%:p:h")
								-- 	lga_actions.quote_prompt({ postfix = " -ig **//**" })
								-- end,
								["<C-i>"] = lga_actions.quote_prompt({
									postfix = " -ig **" .. vim.fn.expand("%:p:h") .. "/**",
								}),
							},
						},
					},
				},
				defaults = {
					file_ignore_patterns = {
						"bazel",
						"node_modules",
						"toolchain",
						"src/vendor",
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("live_grep_args")

			local colors = require("tokyonight.colors").setup({ transform = true })
			local TelescopeColor = {
				-- TelescopeMatching = { fg = colors.blue2 },
				-- TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
				-- TelescopePromptPrefix = { bg = colors.surface0 },
				-- TelescopePromptNormal = { bg = colors.surface0 },
				-- TelescopeResultsNormal = { bg = colors.mantle },
				-- TelescopePreviewNormal = { bg = colors.mantle },
				TelescopePromptBorder = { bg = colors.black, fg = colors.blue7 },
				TelescopeResultsBorder = { bg = colors.black, fg = colors.blue7 },
				TelescopePreviewBorder = { bg = colors.black, fg = colors.blue7 },
				TelescopePromptTitle = { bg = colors.black, fg = colors.blue7 },
				TelescopeResultsTitle = { bg = colors.black, fg = colors.blue7 },
				TelescopePreviewTitle = { bg = colors.black, fg = colors.blue7 },
			}

			for hl, col in pairs(TelescopeColor) do
				vim.api.nvim_set_hl(0, hl, col)
			end
		end,
	},
}
