return {
	"Bekaboo/deadcolumn.nvim",
	config = function()
		require("deadcolumn").setup()
		vim.opt.colorcolumn = "80,100,120"
	end,
}
-- vim: ts=2 sts=2 sw=2 et
