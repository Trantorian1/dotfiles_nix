return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"catppuccin/nvim",
	},
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {

			mode = "tabs",
			indicator = "underline",
			separator_style = "slant",
		},
	},
	keys = {
		{
			"<leader>tt",
			":BufferLinePick<CR>",
			{ desc = "pick [T]ab" },
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
