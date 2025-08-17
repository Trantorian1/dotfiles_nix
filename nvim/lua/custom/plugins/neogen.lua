return {
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup()
		end,
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
