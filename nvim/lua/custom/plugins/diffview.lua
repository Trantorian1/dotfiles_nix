return {
	{
		"sindrets/diffview.nvim",
		config = function()
			local diffview = require("diffview")
			local actions = require("diffview.actions")

			local desc = function(desc)
				return "[M]erge " .. desc
			end

			diffview.setup({
				enhanced_diff_hl = true,
				view = {
					merge_tool = {
						layout = "diff3_mixed",
					},
				},
				keymaps = {
					view = {
						{
							"n",
							"[x",
							actions.prev_conflict,
							{ desc = desc("jump to next conflit") },
						},
						{
							"n",
							"]x",
							actions.next_conflict,
							{ desc = desc("jump to previous conflit") },
						},
						{
							"n",
							"<leader>mco",
							actions.conflict_choose("ours"),
							{ desc = desc("[C]hoose [O]urs (single diff)") },
						},
						{
							"n",
							"<leader>mct",
							actions.conflict_choose("theirs"),
							{ desc = desc("[C]hoose [T]heirs (single diff)") },
						},
						{
							"n",
							"<leader>mcb",
							actions.conflict_choose("base"),
							{ desc = desc("[C]hoose [B]ase (single diff)") },
						},
						{
							"n",
							"<leader>mca",
							actions.conflict_choose("all"),
							{ desc = desc("[C]hoose [A]ll (single diff)") },
						},
						{
							"n",
							"<leader>mcn",
							actions.conflict_choose("none"),
							{ desc = desc("[C]hoose [N]one (single diff)") },
						},
						{
							"n",
							"<leader>mcO",
							actions.conflict_choose_all("ours"),
							{ desc = desc("[C]hoose [O]urs (all diffs)") },
						},
						{
							"n",
							"<leader>mcT",
							actions.conflict_choose_all("theirs"),
							{ desc = desc("[C]hoose [T]heirs (all diffs)") },
						},
						{
							"n",
							"<leader>mcB",
							actions.conflict_choose_all("base"),
							{ desc = desc("[C]hoose [B]ase (all diffs)") },
						},
						{
							"n",
							"<leader>mcA",
							actions.conflict_choose_all("all"),
							{ desc = desc("[C]hoose [A]ll (all diffs)") },
						},
						{
							"n",
							"dX",
							actions.conflict_choose_all("none"),
							{ desc = desc("[C]hoose [N]one (all diffs)") },
						},
					},
				},
			})
		end,
	},
}
