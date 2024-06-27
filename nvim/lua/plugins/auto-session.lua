return {
	"rmagatti/auto-session",
	config = function()
		local function close_nvim_tree()
			require("nvim-tree.api").tree.close()
		end
		local function open_nvim_tree()
			require("nvim-tree.api").tree.open()
		end

		require("auto-session").setup({
			log_level = "error",
			auto_session_suppress_dirs = { "~/" },
			auto_session_use_git_branch = true,
			pre_save_cmds = { close_nvim_tree },
			post_save_cmds = { open_nvim_tree },
			post_open_cmds = { open_nvim_tree },
			post_restore_cmds = { open_nvim_tree },
		})
	end,
}
