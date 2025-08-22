return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"mrcjkb/rustaceanvim",
	},
	lazy = true,
	config = function()
		require("neotest").setup({
			adapters = {
				require("rustaceanvim.neotest"),
			},
			floating = {
				border = "rounded",
			},
		})
	end,
	lazy = true,
	cmd = "Neotest",
	keys = {
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			-- mode = { "n", "x", "o" },
			-- desc = "[T]est [R]un",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			-- mode = { "n", "x", "o" },
			-- desc = "[T]est [F]ile",
		},
		{
			"<leader>ts",
			function()
				require("neotest").run.stop(vim.fn.expand("%"))
			end,
			-- mode = { "n", "x", "o" },
			-- desc = "[T]est [S]top",
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
