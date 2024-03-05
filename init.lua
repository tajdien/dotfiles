local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

-- todo
-- 1. alwatys open Neotree 3. telescope search only move certain lines when scrolling wiht mousewheel clean up file
-- move plugins to plugin folder
-- Make copy pasta work in kitty
-- make noice nice and try to make it work as i expect
-- prettier times out one large files
-- Add eslint lmfao

-- Leader set to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")
require("scripts")

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
	print("Installing lazy.nvim....")
	vim.fn.system({
		"git",
		"clone",
		"filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"branch=stable", -- latest stable release
		lazypath,
	})
	print("Done.")
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require("lazy").setup({
	-- completely useless
	{
		"tamton-aquib/duck.nvim",
		config = function()
			vim.keymap.set("n", "<leader>dd", function()
				require("duck").hatch()
			end, { desc = "Hatch a new duck" })
			vim.keymap.set("n", "<leader>dk", function()
				require("duck").cook()
			end, { desc = "Cook the current duck" })
			vim.keymap.set("n", "<leader>da", function()
				require("duck").cook_all()
			end, { desc = "Cook all the ducks" })
		end,
	},

	-- THEMES
	{ "Mofiqul/dracula.nvim", lazy = false, priority = 1000, opts = {} },
	-- { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
	-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},

	{
		"LintaoAmons/scratch.nvim",
		event = "VeryLazy",
	},
	{ "onsails/lspkind.nvim" },

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		-- dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		dependencies = { "MunifTanjim/nui.nvim" },
	},

	{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
	{ "github/copilot.vim" }, -- copilot
	{ "folke/which-key.nvim", ots = {} }, -- show which keybinds are available
	{ "stevearc/conform.nvim" }, -- formatter

	-- { "justinmk/vim-sneak" }, -- Sneak with S
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").create_default_mappings()
		end,
	},

	{ "tpope/vim-repeat" }, -- Enables repeating of commands from plugins with . TODO

	{ "tzachar/highlight-undo.nvim" }, -- Highlights the last undo and redo

	-- { "echwsnovski/mini.nvim" }, -- Auto close and open pairs like {[ ...
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup()
		end,
	},

	-- Comment shortcut
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({})
		end,
	},
	-- Smooth scrolling
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	-- Git signs on the left side
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
				},
			})
		end,
	},
	-- telescope for code-actions and more -- todo
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- todo
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	build = ":Copilot auth",
	-- 	-- opts = {
	-- 	-- 	auto_trigger = true,
	-- 	-- 	suggestion = { enabled = false },
	-- 	-- 	panel = { enabled = false },
	-- 	-- 	filetypes = {
	-- 	-- 		markdown = true,
	-- 	-- 		help = true,
	-- 	-- 		gitcommit = false,
	-- 	-- 	},
	-- 	-- },
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			suggestions = {
	-- 				enabled = true,
	-- 				auto_refresh = true,
	-- 				keymap = {
	-- 					jump_prev = "[[",
	-- 					jump_next = "]]",
	-- 					accept = "<CR>",
	-- 					-- refresh = "gr",
	-- 					open = "<M-CR>",
	-- 				},
	-- 				layout = {
	-- 					position = "bottom", -- | top | left | right
	-- 					ratio = 0.4,
	-- 				},
	-- 			},
	-- 			suggestion = {
	-- 				enabled = true,
	-- 				auto_trigger = false,
	-- 				debounce = 75,
	-- 				keymap = {
	-- 					accept = "<M-l>",
	-- 					accept_word = false,
	-- 					accept_line = false,
	-- 					next = "<M-]>",
	-- 					prev = "<M-[>",
	-- 					dismiss = "<C-]>",
	-- 				},
	-- 			},
	-- 			filetypes = {
	-- 				yaml = false,
	-- 				markdown = false,
	-- 				help = false,
	-- 				gitcommit = false,
	-- 				gitrebase = false,
	-- 				hgcommit = false,
	-- 				svn = false,
	-- 				cvs = false,
	-- 				["."] = false,
	-- 			},
	-- 			copilot_node_command = "node", -- Node.js version must be > 18.x
	-- 			server_opts_overrides = {},
	-- 		})
	-- 	end,
	-- },
	--
	{
		"f-person/git-blame.nvim",
		config = function()
			require("gitblame").setup({
				enabled = false,
			})
		end,
	},

	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = vim.opt.sessionoptions:get() },
  -- stylua: ignore
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
	},

	{
		"rest-nvim/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("rest-nvim").setup({
				result_split_in_place = true,
				stay_in_current_window_after_split = true, -- stay in current windows (.http file) or change to results window (default)
				encode_url = true, -- Encode URL before making request
				highlight = {
					enabled = true,
					timeout = 350,
				},
				result = {
					show_url = true,
					show_curl_command = false,
					show_http_info = true,
					show_headers = true,
					show_statistics = false,
					formatters = {
						json = "jq", -- auto format json responses with jq
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
			})
		end,
	},

	-- jest todo
	{
		"David-Kunz/jester",
		config = function()
			require("jester").setup({})
		end,
	},

	-- Turbo log TODO fork and make it work as i want
	{ "https://github.com/gaelph/logsitter.nvim" },

	{
		-- LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim", -- Additional lua configuration, makes nvim stuff amazing!
		},
	},

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip", -- Snippet Engine & its associated nvim-cmp source
			"saadparwaiz1/cmp_luasnip", -- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp", -- Adds a number of user-friendly snippetsvim
			"rafamadriz/friendly-snippets",
		},
	},

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
			},
		},
	},

	-- Highlight, edit, and navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
	},

	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = true
		end,
		opts = {
			sidebar_filetypes = {
				["neo-tree"] = { event = "BufWipeout", text = "Neotree" },
			},
			icons = {
				button = false,
			},
		},
	},

	-- Tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},

	-- Neogit
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},

	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- highlights unique characters when navigating with fFtT
	{
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true, -- show highlights only after keypress
				dim = true, -- dim all other characters
			})
		end,
	},
})

-- vim.api.nvim_create_augroup("LogSitter", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = "Logsitter",
-- 	pattern = "javascript,go,lua",
-- 	callback = function()
-- 		vim.keymap.set("n", "<leader>lg", function()
-- 			require("logsitter").log()
-- 		end)
-- 	end,
-- })
--
--
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
	command = "silent! EslintFixAll",
	group = vim.api.nvim_create_augroup("MyAutocmdsJavaScripFormatting", {}),
})

-- vim.cmd([[colorscheme tokyonight-night]]) -- colorscheme
vim.cmd([[colorscheme dracula]]) -- colorscheme

-- [[ Telescope KEYBINDS ]]
-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
-- vim.keymap.set("n", "<leader>ff", function()
-- 	-- You can pass additional configuration to telescope to change theme, layout, etc.
-- 	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
-- 		winblend = 20,
-- 		previewer = true,
-- 	}))
-- end, { desc = "Fuzzily search in current buffer" })
vim.keymap.set(
	"n",
	"<leader>ff",
	require("telescope.builtin").current_buffer_fuzzy_find,
	{ desc = "Fuzzily search in current buffer" }
)

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").symbols, { desc = "[S]earch [S]ymbols" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sp", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- Todo
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
-- vim.keymap.set("n", "<leader><space>", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

-- [[ Basic Keymaps ]]

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- [[ Conform ]]
-- https://github.com/stevearc/conform.nvim
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		vue = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		less = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
	},
	format_on_save = { timeout_ms = 50 },
	format_after_save = { lsp_fallback = true },
	async = true,
	quiet = true,
})

-- [[ Neo-tree ]]
-- https://github.com/nvim-neo-tree/neo-tree.nvim
require("neo-tree").setup({
	close_if_last_window = true,
	filesystem = {
		window = {
			mapping_options = {
				noremap = true,
				nowait = false,
			},
			mappings = {
				["o"] = { command = "open", nowait = true },
				["O"] = { command = "open", nowait = true },
				-- Change 'o' bindings to have leader
				["oc"] = "noop",
				["<leader>oc"] = { command = "order_by_created", nowait = true },
				["od"] = "noop",
				["<leader>od"] = { command = "order_by_diagnostics", nowait = true },
				["og"] = "noop",
				["<leader>og"] = { command = "order_by_git_status", nowait = true },
				["om"] = "noop",
				["<leader>om"] = { command = "order_by_modified", nowait = true },
				["on"] = "noop",
				["<leader>on"] = { command = "order_by_name", nowait = true },
				["os"] = "noop",
				["<leader>os"] = { command = "order_by_size", nowait = true },
				["ot"] = "noop",
				["<leader>ot"] = { command = "order_by_type", nowait = true },
			},
		},
	},
	-- todo: open if no buffer is active
	-- todo: pressing tab should focus on active buffer
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree left reveal_force_cwd<cr>", { desc = "Shows Neotree in current file" })
vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle<cr>", { desc = "Toggles Neotree" })

-- [[ Configure Telescope ]]
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
			-- pseudo code / specification for writing custom displays, like the one
			-- for "codeactions"
			-- specific_opts = {
			--   [kind] = {
			--     make_indexed = function(items) -> indexed_items, width,
			--     make_displayer = function(widths) -> displayer
			--     make_display = function(displayer) -> function(e)
			--     make_ordinal = function(e) -> string
			--   },
			--   -- for example to disable the custom builtin "codeactions" display
			--      do the following
			--   codeactions = false,
			-- }
		},
	},
})

-- To get ui-select loaded and working with telescope, you need to call load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
	-- Use the current buffer's path as the starting point for the git search
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	local cwd = vim.fn.getcwd()
	-- If the buffer is not associated with a file, return nil
	if current_file == "" then
		current_dir = cwd
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ":h")
	end

	-- Find the Git root directory from the current file's path
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		print("Not a git repository. Searching on current working directory")
		return cwd
	end
	return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
	local git_root = find_git_root()
	if git_root then
		require("telescope.builtin").live_grep({
			search_dirs = { git_root },
		})
	end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim export PATH=$PATH:/path/to/hg/directory{filename}'
vim.defer_fn(function()
	require("nvim-treesitter.configs").setup({
		-- Add languages to be installed here
		ensure_installed = {
			"cpp",
			"lua",
			"python",
			"rust",
			"tsx",
			"javascript",
			"typescript",
			"vimdoc",
			"vim",
			"bash",
			"markdown",
			"regex",
			"markdown_inline",
			"http",
			"json",
		},

		-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
		auto_install = true,

		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "m",
				node_incremental = "m",
				scope_incremental = "<c-s>",
				node_decremental = "M",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		},
	})
end, 0)

require("highlight-undo").setup({
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
})

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ss", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- Rename
	nmap("<leader>re", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	-- TODO this looks very with dracula, add border around it
	-- see here https://github.com/jdhao/nvim-config/blob/master/lua/config/lsp.lua#L177-L179
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
	-- 	vim.lsp.buf.format()
	-- end, { desc = "Format current buffer with LSP" })
end

-- document existing key chains
require("which-key").register({
	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
	["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
	["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
})

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

-- Enable the following language servers
--  Add/remove any LSPs. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	tsserver = {},
	eslint = {
		{
			bin = "eslint", -- or `eslint_d`
			code_actions = {
				enable = true,
				apply_on_save = {
					enable = true,
					types = { "directive", "problem", "suggestion", "layout" },
				},
				disable_rule_comment = {
					enable = true,
					location = "separate_line", -- or `same_line`
				},
			},
			diagnostics = {
				enable = true,
				report_unused_disable_directives = false,
				run_on = "save", -- or `save`
			},
		},
	},
	-- html = { filetypes = { 'html', 'twig', 'hbs'} },

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = { disable = { "missing-fields" } }, -- disables "missing-fields" warning
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	window = {
		completion = {
			border = "rounded",
			-- winhighlight = "Normal:Pmenu,CursorLine:CmpCursorLine,Search:None",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None",
			-- col_offset = -3,
			side_padding = 1,
			scrollbar = false,
		},
		-- documentation = {
		-- 	border = "rounded",
		-- 	-- winhighlight = "Normal:CmpDoc,FloatBorder:CmpDoc,Search:None",
		-- 	-- max_width = 80,
		-- 	-- max_height = 12,
		-- },
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- can also be a function to dynamically calculate max width such as
			-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
			ellipsis_char = "..", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			show_labelDetails = true, -- show labelDetails in menu. Disabled by default
		}),
	},
	sorting = { -- Very hard to find actual documentation on this
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.recently_used,
			cmp.config.compare.sort_text,
			cmp.config.compare.score,
			-- require("cmp-under-comparator").under,
			cmp.config.compare.kind,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			-- https://www.reddit.com/r/neovim/comments/xk5uno/nvimcmp_opens_suggestions_when_entering_a_new_line/
			-- deactivated to not suggest on empty line when pressing enter
			-- select = true,
		}),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expand_or_locally_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
