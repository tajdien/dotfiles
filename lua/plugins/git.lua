local M
local Utils = require("utils")

M = {
	-- Git Menu
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
		keys = {
			{ "<leader>gm", "<CMD>Neogit<CR>", desc = "Neogit: [G]it [M]enu" },
			{ "gm", "<CMD>Neogit<CR>", desc = "Neogit: [G]it [M]enu" },
		},
	},

	-- Git shortcuts
	{ "lewis6991/gitsigns.nvim", config = true },

	-- Git signs on the left side
	{ "tpope/vim-fugitive", lazy = true, config = true },

	-- TODO: Might be replaced with Fugitive
	{
		"f-person/git-blame.nvim",
		opts = { enabled = false }, -- disable by default,
		keys = {
			{ "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Git-Blame: Toggle [G]it [B]lame" },
		},
	},
}

return M
