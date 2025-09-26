return {
	"MeanderingProgrammer/markdown.nvim",
	name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		html = {
			comment = {
				conceal = false,
			},
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
