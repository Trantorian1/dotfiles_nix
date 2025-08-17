return {
	"Bekaboo/deadcolumn.nvim",
	config = function()
		require("deadcolumn").setup()
		vim.opt.colorcolumn = "80,100,120"
	end,
}
