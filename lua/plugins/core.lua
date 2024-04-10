local M

M = {
	-- Colorscheme
	{
		"dracula/vim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd([[colorscheme dracula]])
		end,
	},

	-- Scratch pad
	{
		"LintaoAmons/scratch.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>snn", "<cmd>Scratch<cr>", desc = { "[s]ratch [n]ew" } },
			{ "<leader>so", "<cmd>ScratchOpen<cr>", desc = { "[s]ratch [o]pen" } },
		},
	},

	-- Highlights the last undo and redo
	{
		"tzachar/highlight-undo.nvim",
		opts = {
			duration = 500,
			undo = {
				hlgroup = "HighlightUndo",
				mode = "n",
				lhs = "u",
				map = "undo",
				opts = {},
			},
			redo = {
				hlgroup = "HighlightUndo",
				mode = "n",
				lhs = "U",
				map = "redo",
				opts = {},
			},
			highlight_for_count = true,
		},
	},

	-- Highlights text objects under cursor
	{ "tzachar/local-highlight.nvim" },

	-- turbo console log
	{ "gaelph/logsitter.nvim" },

	-- Detect tabstop and shiftwidth automatically
	{ "tpope/vim-sleuth" },

	-- copilot
	{ "github/copilot.vim" },

	-- show which keybinds are available
	{
		"folke/which-key.nvim",
		config = function()
			local whichKey = require("which-key")
			whichKey.register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
				["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			})
		end,
	},

	-- Session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = vim.opt.sessionoptions:get() },
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}

return M
