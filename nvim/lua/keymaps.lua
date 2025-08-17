-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Scrolling
vim.keymap.set("n", "<S-s>", "<C-e>", { desc = "Scroll down" })
vim.keymap.set("n", "<S-w>", "<C-y>", { desc = "Scroll down" })

-- Set full screen in neovide
local fullscreen = false
vim.keymap.set("n", "<F11>", function()
	fullscreen = not fullscreen
	vim.g.neovide_fullscreen = fullscreen
end, { desc = "Fullsceen" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Open default tabs on startup
vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Open default tabs  on startup",
	group = vim.api.nvim_create_augroup("kickstart-open-default", { clear = true }),
	callback = function()
		if vim.fn.argc() == 0 then
			-- First tab: empty (this is already open by default)

			-- Second tab: git diff with diffview
			vim.cmd("DiffviewOpen")

			-- Third tab: terminal
			vim.cmd("tabnew")
			vim.cmd("term")
			vim.cmd("vspl")
			vim.cmd("term")

			-- Go back to first tab
			vim.cmd("tabfirst")
		end
	end,
})

-- vim: ts=2 sts=2 sw=2 et
