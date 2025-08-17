return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.laststatus = 3
		vim.opt.splitkeep = "screen"
	end,
	opts = {
		right = {
			{
				ft = "help",
				-- only show help buffers
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
		},

		options = {
			right = { size = 90 },
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
}
