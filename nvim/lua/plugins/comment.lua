return {
	"numToStr/Comment.nvim",
	opts = {},
	lazy = false,
	config = function()
		require("Comment").setup({
			mappings = {
				---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = true,
			},
		})
	end,
}
