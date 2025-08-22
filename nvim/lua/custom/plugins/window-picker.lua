return {
	"s1n7ax/nvim-window-picker",
	name = "window-picker",
	event = "VeryLazy",
	version = "2.*",
	opts = {
		hint = "floating-letter",
	},
	keys = {
		{
			"<leader>ww",
			function()
				local window_id = require("window-picker").pick_window()
				vim.api.nvim_set_current_win(window_id)
			end,
			{ desc = "pick [W]indow" },
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
