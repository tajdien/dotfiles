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
	{ "gaelph/logsitter.nvim", opts = {
		path_format = "fileonly",
		prefix = "📚",
	} },

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

	-- Markdown preview in browser
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
		},
	},

	-- -- Simplify macro recording
	-- {
	-- 	"chrisgrieser/nvim-recorder",
	-- 	opts = {},
	-- },

	-- Lua package manager
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},

	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		opts = {
			workspaces = {
				{
					name = "Vault",
					path = "~/documents/Vault",
				},
			},
		},
	},

	-- Test runner
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-jest",
		},
		config = function()
			require("neotest").setup({
				discovery = { enabled = false },
				output = { open_on_run = true },
				adapters = {
					require("neotest-jest")({
						jestCommand = "npm test --",
						jestConfigFile = function(file)
							if string.find(file, "/packages/") then
								return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
							end

							return vim.fn.getcwd() .. "/jest.config.ts"
						end,
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
					}),
				},
			})
		end,
		-- stylua: ignore
		keys = {
			{ "<leader>tr", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "run test" },
			{ "<leader>tw", function() require("neotest").run.run({ jestCommand = "jest --watch " }) end, desc = "run test in watch" }, -- todo
			{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
		},
	},
}

return M
