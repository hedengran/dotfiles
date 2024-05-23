return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "<leader>gd", function()
					gs.toggle_linehl()
					gs.toggle_deleted()
				end)
				map("n", "<leader>gs", gs.stage_hunk)
				map("n", "<leader>gr", gs.reset_hunk)
				map("n", "<leader>gS", gs.stage_buffer)
				map("n", "<leader>gR", gs.reset_buffer)
				map("n", "<leader>gp", gs.preview_hunk)
				map("n", "<leader>gB", function()
					gs.blame_line({ full = true })
				end)
			end,
		})
	end,
}
