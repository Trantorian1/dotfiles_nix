return {
	"RaafatTurki/hex.nvim",
	opts = {
		dump_cmd = "xxd -g 1 -b",
		assemble_cmd = "xxd -r -b",
	},
	keys = {
		{
			"<leader>vb",
			function()
				require("hex").toggle()
			end,
			{ desc = "[V]iew [B]inary" },
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
