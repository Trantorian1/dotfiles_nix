return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = {
				enabled = true,
				highlight = { backdrop = true },
			},
		},
	},
	keys = {
		{
			"<leader>ss",
			function()
				require("flash").jump()
			end,
			mode = { "n", "x", "o" },
			desc = "[S]earch [S]imple",
		},
		{
			"<leader>sc",
			function()
				require("flash").treesitter_search()
			end,
			mode = { "n", "x", "o" },
			desc = "[S]earch [C]ontext",
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
