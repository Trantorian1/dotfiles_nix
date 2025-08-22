return {
	{
		"danymat/neogen",
		opts = {},
		keys = {
			{
				"<leader>dc",
				function()
					require("neogen").generate()
				end,
				{ desc = "[D]ocument [C]ode" },
			},
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
