return {
	"f-person/auto-dark-mode.nvim",
	lazy = true,
	event = "VimEnter",
	opts = {
		set_dark_mode = function()
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
		set_light_mode = function()
			vim.cmd.colorscheme("catppuccin-latte")
		end,
		update_interval = 1000,
		fallback = "dark",
	},
}
-- vim: ts=2 sts=2 sw=2 et
