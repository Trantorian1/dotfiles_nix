return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.laststatus = 3
		vim.opt.splitkeep = "screen"
	end,
	---@type Edgy.Config
	opts = {
		left = {
			{ ft = "dapui_scopes" },
			{ ft = "dapui_breakpoints" },
			{ ft = "dapui_watches" },
			{ ft = "dap-repl" },
		},

		right = {
			{
				ft = "help",
				-- only show help buffers
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
			{
				ft = "neotest-summary",
				pinned = true,
				collapsed = true,
				open = "Neotest summary",
			},
		},

		bottom = {
			{ ft = "dap_disassembly" },
		},

		options = {
			left = { size = 50 },
			right = { size = 90 },
			bottom = { size = 15 },
		},

		animate = {
			enabled = false,
		},

		-- enable this to exit Neovim when only edgy windows are left
		exit_when_last = true,
		-- close edgy when all windows are hidden instead of opening one of them
		-- disable to always keep at least one edgy split visible in each open section
		close_when_all_hidden = true,
	},
	keys = {
		{
			"<leader>ol",
			function()
				require("edgy").toggle("left")
			end,
			mode = { "n", "x", "o" },
			desc = "[O]pen [L]ight window",
		},
		{
			"<leader>or",
			function()
				require("edgy").toggle("right")
			end,
			mode = { "n", "x", "o" },
			desc = "[O]pen [R]ight window",
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
