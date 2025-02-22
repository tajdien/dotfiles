local M

M = {
	{
		"maxmx03/dracula.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd([[colorscheme dracula]])
		end,
	},

	-- better comments
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
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

	-- -- turbo console log
	{
		"Goose97/timber.nvim",
		event = "VeryLazy",
		config = function()
			require("timber").setup({
				-- log_templates = {
				-- 	default = {
				-- 		javascript = [[console.log("📚 %identifier", %identifier)]],
				-- 		typescript = [[console.log("📚 %identifier", %identifier)]],
				-- 		jsx = [[console.log("📚 %identifier", %identifier)]],
				-- 		tsx = [[console.log("📚 %identifier", %identifier)]],
				-- 		lua = [[print("📚 %identifier", %identifier)]],
				-- 	},
				-- },
				keymaps = {
					insert_log_below = "<leader>cl",
				}
			})
		end
	},
	-- {
	-- 	"gaelph/logsitter.nvim",
	-- 	opts = {
	-- 		path_format = "fileonly",
	-- 		prefix = "📚",
	-- 	},
	-- 	keys = {
	-- 		{ "<leader>cl", "<cmd>lua require('logsitter').log()<cr>", desc = "[L]og" }
	-- 	}
	-- },

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
		'rmagatti/auto-session',
		lazy = false,
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
		}
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

	-- Lua package manager
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},


	{
		"shortcuts/no-neck-pain.nvim",
		version = "*"
	},

	{
		'stevearc/overseer.nvim',
		opts = {},
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require('tiny-inline-diagnostic').setup()
		end
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

	{
		'rgroli/other.nvim',
		opts = {
			mappings = {
				"react",
			}
		},
		keys = {
			{ "<leader>so", "<cmd>:Other<CR>", desc = "[O]ther" }
		}
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		opts = {
			menu = { width = vim.api.nvim_win_get_width(0) - 4 },
			settings = { save_on_toggle = true }
		},
		keys = function()
			local keys = {
				{
					"<leader>H",
					function()
						require("harpoon"):list():add()
					end,
					desc = "Harpoon File",
				},
				{
					"<leader>h",
					function()
						local harpoon = require("harpoon")
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					desc = "Harpoon Quick Menu",
				},
			}

			for i = 1, 5 do
				table.insert(keys, {
					"<leader>" .. i,
					function()
						require("harpoon"):list():select(i)
					end,
					desc = "Harpoon to File " .. i,
				})
			end
			return keys
		end,
	},
}

return M
