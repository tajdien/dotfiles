local M

local function handle_references_response(result)
	require("telescope.pickers")
		.new({}, {
			prompt_title = "LSP References",
			finder = require("telescope.finders").new_table({
				results = vim.lsp.util.locations_to_items(result, "utf-16"),
				entry_maker = require("telescope.make_entry").gen_from_quickfix(),
			}),
			previewer = require("telescope.config").values.qflist_previewer({}),
		})
		:find()
end

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

	-- JetBrains
	{
		"KostkaBrukowa/definition-or-references.nvim",
		config = function()
			require("definition-or-references").setup({
				on_references_result = handle_references_response,
			})
		end,
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

	-- Test runner
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
		},
		config = function()
			require("neotest").setup({
				adapter = {
					require("neotest-jest")({
						jestCommand = "npm test --",
						jestConfigFile = "custom.jest.config.ts",
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
					}),
				},
			})
		end,
		keys = {
			{
				"<leader>tr",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "run test",
			},
		},
	},
}

return M
