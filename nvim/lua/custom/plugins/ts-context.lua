return {
	"nvim-treesitter/nvim-treesitter-context",
	main = "treesitter-context",
	opts = {
		enable = true,
		multiwindow = true,
		max_lines = 7,
	},
	lazy = true,
	event = "BufEnter",
	keys = {
		{
			"<leader>tc",
			"<CMD>TSContextToggle<CR>",
			{ desc = "[T]oggle function [C]ontext" },
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
