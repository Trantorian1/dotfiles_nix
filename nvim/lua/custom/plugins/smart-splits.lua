return {
	{
		"mrjones2014/smart-splits.nvim",
		opts = {
			resize_mode = {
				silent = false,
			},
		},
		keys = {
			-- movement motions
			{
				"<M-Left>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				{ desc = "Move cursor left" },
			},
			{
				"<M-Right>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				{ desc = "Move cursor right" },
			},
			{
				"<M-Up>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				{ desc = "Move cursor up" },
			},
			{
				"<M-Down>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				{ desc = "Move cursor down" },
			},

			-- resize motions
			{
				"<M-S-Left>",
				function()
					require("smart-splits").resize_left()
				end,
				{ desc = "Resize left" },
			},
			{
				"<M-S-Right>",
				function()
					require("smart-splits").resize_right()
				end,
				{ desc = "Resize right" },
			},
			{
				"<M-S-Up>",
				function()
					require("smart-splits").resize_up()
				end,
				{ desc = "Resize up" },
			},
			{
				"<M-S-Down>",
				function()
					require("smart-splits").resize_down()
				end,
				{ desc = "Resize down" },
			},
		},
	},
}
