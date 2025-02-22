local M

local Utils = require("utils")

M = {
	-- formatter
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				-- typescript = { "prettier" },
				typescriptreact = { "prettier" },
				-- vue = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
			},
			-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
			-- format_after_save = { timeout_ms = 500, lsp_fallback = true },
			async = true,
			quiet = true,
		},
	},

	-- Leap with S
	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", "<Plug>(leap)",             { mode = "n" } },
			{ "S", "<Plug>(leap-from-window)", { mode = "n" } },
			{ "s", "<Plug>(leap-forward)",     { mode = { "x", "o" } } },
			{ "S", "<Plug>(leap-backward)",    { mode = { "x", "o" } } },
		},
	},

	-- Smooth scrolling
	{ "karb94/neoscroll.nvim",  config = true },

	-- Automatically close pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- Surround text with brackets, quotes, etc
	{ "kylechui/nvim-surround", config = true },

	-- automatically highlighting text objects
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure()
		end,
	},

	-- indent lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},

	-- Rainbow parentheses
	{
		"frazrepo/vim-rainbow",
		config = function()
			vim.g.rainbow_active = 1
		end,
	},

	-- Tailwind tools
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		opts = {}
	},

	-- {
	-- 		"maxmx03/dracula.nvim",
	-- 		lazy = false,
	-- 		priority = 1000,
	-- 		opts = {},
	-- 		config = function()
	-- 			vim.cmd([[colorscheme dracula]])
	-- 		end,
	-- 	}

	{
		"windwp/nvim-ts-autotag",
		config = function()
			require('nvim-ts-autotag').setup()
		end
	}
}

return M
