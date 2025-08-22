return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				barbar = true,
				blink_cmp = {
					style = "bordered",
				},
				diffview = true,
				fidget = true,
				flash = true,
				gitsigns = true,
				neotest = true,
				noice = true,
				render_markdown = true,
				which_key = true,
				dap = true,
				dap_ui = true,
			},
		})
		vim.cmd.colorscheme("catppuccin-macchiato")
	end,
}
-- vim: ts=2 sts=2 sw=2 et
