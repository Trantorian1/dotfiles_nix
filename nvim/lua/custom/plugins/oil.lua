return {
	"stevearc/oil.nvim",
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
		-- Set to false if you still want to use netrw.
		default_file_explorer = true,
		-- Id is automatically added at the beginning, and name at the end
		-- See :help oil-columns
		columns = {
			"icon",
			"permissions",
			"size",
			-- "mtime",
		},
		-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
		-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
		-- Additionally, if it is a string that matches "actions.<name>",
		-- it will use the mapping at require("oil.actions").<name>
		-- Set to `false` to remove a keymap
		-- See :help oil-actions for a list of all available actions
		keymaps = {
			["<leader>f?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<leader>fp"] = "actions.preview",
			[".."] = "actions.parent",
			["."] = "actions.open_cwd",
		},
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
		},
	},
	keys = {
		{
			"<leader>fo",
			function()
				require("oil").open_float()
			end,
			{ desc = "[F]ile tree [O]pen" },
		},
		{
			"<leader>fc",
			function()
				require("oil").close()
			end,
			{ desc = "[F]ile tree [C]lose" },
		},
		{
			"<leader>fs",
			function()
				require("oil").save()
			end,
			{ desc = "[F]ile tree [S]ave" },
		},
		{
			"<leader>fd",
			function()
				require("oil").discard_all_changes()
			end,
			{ desc = "[F]ile tree [D]iscard" },
		},
	},
}
