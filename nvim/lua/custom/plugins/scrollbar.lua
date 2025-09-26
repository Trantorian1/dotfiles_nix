return {
	"petertriho/nvim-scrollbar",
	opts = {
		marks = {
			Error = {
				Search = {
					text = { "" },
					priority = 1,
					color = "#f0c971",
					highlight = "Search",
				},
				text = { "" },
				priority = 2,
				color = "#eb5151",
				highlight = "DiagnosticVirtualTextError",
			},
			Warn = {
				text = { "" },
				priority = 3,
				color = "#f0c971",
				highlight = "DiagnosticVirtualTextWarn",
			},
			Info = {
				text = { "" },
				priority = 4,
				color = "#43b7f2",
				highlight = "DiagnosticVirtualTextInfo",
			},
			GitAdd = {
				text = "+",
				priority = 7,
				color = "#96f063",
				highlight = "GitSignsAdd",
			},
			GitChange = {
				text = "~",
				priority = 7,
				color = "#f0c971",
				highlight = "GitSignsChange",
			},
			GitDelete = {
				text = "-",
				priority = 7,
				color = "#eb5151",
				highlight = "GitSignsDelete",
			},
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
