return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		require("dapui").setup()
		-- require("dap-go").setup({
		-- 	delve = {
		-- 		cwd = "src",
		-- 	},
		-- })
		require("nvim-dap-virtual-text").setup()
		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		-- vim.keymap.set("n", "<space>db", dap.toggle_breakpoint)
		-- vim.keymap.set("n", "<space>rc", dap.run_to_cursor)
		-- vim.keymap.set("n", "<space>?", function()
		-- 	require("dapui").eval(nil, { enter = true })
		-- end)

		-- vim.keymap.set("n", "<F1>", dap.continue)
		-- vim.keymap.set("n", "<F2>", dap.step_into)
		-- vim.keymap.set("n", "<F3>", dap.step_over)
		-- vim.keymap.set("n", "<F4>", dap.step_out)
		-- vim.keymap.set("n", "<F5>", dap.step_back)
		-- vim.keymap.set("n", "<F6>", dap.restart)

		dap.configurations.go = {
			{
				type = "delve",
				name = "Debug test", -- configuration for debugging test files
				request = "launch",
				mode = "test",
				program = "${relativeFileDirname}",
				cwd = "src",
				-- program = function()
				-- 	return vim.fn.expand("%:.:h")
				-- end,
			},
		}

		-- Start delve like this, from "src" dir:
		--		dlv dap -l 127.0.0.1:38697 --log --log-output="dap"
		-- dap.adapters.delve = {
		-- 	type = "server",
		-- 	host = "127.0.0.1",
		-- 	port = 38697,
		-- }

		dap.adapters.delve = {
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
				cwd = "src",
			},
		}

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
