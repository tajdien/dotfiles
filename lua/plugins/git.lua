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

	{
		"FabijanZulj/blame.nvim",
		cmd = "ToggleBlame",
		-- stylua: ignore
		keys = {
			{ '<leader>gb', '<cmd>ToggleBlame virtual<CR>', desc = 'Git blame' },
			{ '<leader>gB', '<cmd>ToggleBlame window<CR>', desc = 'Git blame (window)' },
		},
		opts = {
			date_format = "%Y-%m-%d %H:%M",
			merge_consecutive = true,
		},
	},
}

return M
