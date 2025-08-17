return {
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {
			toggler = {
				-- Line-comment toggle keymap
				line = "cc",
				-- Block-comment toggle keymap
				block = "bb",
			},
		},
	},
}
