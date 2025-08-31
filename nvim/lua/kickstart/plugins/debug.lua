-- debug.lua
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Display field values during debugging sessions
		"theHamsta/nvim-dap-virtual-text",

		-- Disassembly view for nvim dapui
		"Jorenar/nvim-dap-disasm",
	},
	keys = {
		{
			"<F5>",
			function()
				vim.cmd.RustLsp("debug")
			end,
			desc = "Debugger: Start Session",
		},
		{
			"<F1>",
			function()
				require("dap").step_into()
			end,
			desc = "Debugger: Step Into",
		},
		{
			"<F2>",
			function()
				require("dap").step_over()
			end,
			desc = "Debugger: Step Over",
		},
		{
			"<F3>",
			function()
				require("dap").step_out()
			end,
			desc = "Debugger: Step Out",
		},
		{
			"<F4>",
			function()
				require("dap").continue()
			end,
			desc = "Debugger: Continue",
		},
		{
			"<leader>dsa",
			function()
				require("dap").step_over({ steppingGranularity = "instruction" })
			end,
			desc = "[D]ebugger: [S]tep Over [Assembly]",
		},
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "[D]ebugger: Toggle [B]reakpoint",
		},
		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		{
			"<leader>dui",
			function()
				require("dapui").toggle()
			end,
			desc = "[D]ebugger: Toggle [UI]",
		},
		{
			"<leader>dw",
			function()
				local snacks = require("snacks")
				local dapui = require("dapui")

				-- Gets the height of the current window
				local win_height = vim.api.nvim_win_get_height(0)
				local center = win_height / 2 - 1

				print(center)

				-- Opens a prompt for the user to enter a watch expression
				local opts = {
					icon = "󰈈",
					prompt = "watch expression",
					win = { style = "input", position = "float", row = center },
				}
				local on_confirm = function(input)
					dapui.elements.watches.add(input)
				end

				snacks.input(opts, on_confirm)
			end,
			desc = "[D]ebugger: [W]atch expression",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Usable screen height
		local bottom = vim.o.cmdheight + (vim.o.laststatus == 3 and 1 or 0)
		local top = (vim.o.showtabline == 2 or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)) and 1
			or 0
		local height = vim.o.lines - top - bottom
		local width = vim.o.columns

		dapui.setup({
			controls = {
				-- Disables clickable icons
				enabled = false,
			},
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "watches",
							size = 0.25,
						},
						{
							id = "repl",
							size = 0.25,
						},
					},
					position = "left",
					size = math.floor(width / 3),
				},
				{
					elements = {
						{
							id = "disassembly",
							size = 1,
						},
					},
					position = "bottom",
					size = math.floor(height / 4),
				},
			},
		})

		require("nvim-dap-virtual-text").setup({})

		-- Change breakpoint icons
		local breakpoint_icons = {
			Breakpoint = "",
			BreakpointCondition = "",
			BreakpointRejected = "",
			LogPoint = "",
			Stopped = "",
		}
		for type, icon in pairs(breakpoint_icons) do
			local tp = "Dap" .. type
			local hl = tp
			vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
		end

		-- Automatically open and close dapui
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
-- vim: ts=2 sts=2 sw=2 et
