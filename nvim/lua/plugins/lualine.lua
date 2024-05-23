return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			--options = { theme = "tokyonight" },
			sections = {
				lualine_c = {
					{
						"filename",
						file_status = true, -- displays file status (readonly status, modified status)
						path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
					},
				},
			},
		})
	end,
}
