local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

-- todo
-- 1. alwatys open Neotree
-- 3. telescope search
-- only move certain lines when scrolling wiht mousewheel
-- clean up file
-- move plugins to plugin folder
-- Make copy pasta work in kitty

-- Leader set to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")

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
	--	spec = { import = "plugins" },
	-- theme
	-- { "Mofiqul/dracula.nvim" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
	{ "github/copilot.vim" }, -- copilot
	{ "folke/which-key.nvim", ots = {} }, -- show which keybinds are available
	-- { "lukas-reineke/indent-blankline.nvim", main = "ibl" }, -- Intention lines
	{ "stevearc/conform.nvim" }, -- formatter
	{ "justinmk/vim-sneak" }, -- Sneak with S
	{ "tpope/vim-repeat" }, -- Enables repeating of commands from plugins with .
	{ "VonHeikemen/fine-cmdline.nvim", dependencies = { { "MunifTanjim/nui.nvim" } } }, -- floating cmd line
	{ "tzachar/highlight-undo.nvim" }, -- Highlights the last undo and redo
	{ "echwsnovski/mini.nvim" }, -- Auto close and open pairs like {[ ...
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{
		"https://github.com/lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
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

	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				-- size can be a number or function which is passed the current terminal
				size = 20,
				open_mapping = [[<C-t>]],
				hide_numbers = true, -- hide the number column in toggleterm buffers
				shade_terminals = true,
				shading_factor = 1, -- degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
				start_in_insert = true, -- start terminal in insert mode
				insert_mappings = true, -- whether or not the open mapping applies in insert mode
				persist_size = true,
				direction = "float",
			})
		end,
	},
	{
		"rest-nvim/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("rest-nvim").setup({
				result_split_in_place = true,
				-- stay in current windows (.http file) or change to results window (default)
				stay_in_current_window_after_split = true,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					-- show the generated curl command in case you want to launch
					-- the same request via the terminal (can be verbose)
					show_curl_command = false,
					show_http_info = true,
					show_headers = true,
					show_statistics = false,
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
			})
		end,
	},
	{
		"David-Kunz/jester",
		config = function()
			require("jester").setup({})
		end,
	}, -- jest
	{ "https://github.com/gaelph/logsitter.nvim" },

	-- TODO: broken: try to fix
	-- {
	-- 	"https://github.com/ggandor/leap.nvim",
	-- 	config = function()
	-- 		require("leap").add_default_mappings()({})
	-- 	end,
	-- },

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
		-- Statusbar at the bottom
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				component_separators = "|",
				section_separators = "",
			},
		},
	},

	-- Highlight, edit, and navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
	},

	-- tabs as tabs ??
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					offsets = {
						{
							filetype = "neo-tree",
							text = "Neotree",
							separator = true,
							text_align = "left",
						},
					},
				},
			})
		end,
	},

	{
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
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

	-- { "https://github.com/nvim-tree/nvim-tree.lua", dependencies = { "kyazdani42/nvim-web-devicons" } },

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

vim.keymap.set("n", "<leader>hc", "<Plug>RestNvim", { desc = "[H]ttp [c]ursor" })
vim.keymap.set("n", "<leader>cl", "<cmd>lua require('logsitter').log()<cr>", { desc = "[L]o[g]" })
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

vim.cmd([[colorscheme catppuccin]]) -- colorscheme

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
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").symbols, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<C-S>o", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sp", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

-- :lua require"jester".run()
-- ```
--
-- ### Run current file
--
-- ```
-- :lua require"jester".run_file()
-- ```
--
-- ### Run last test(s)
--
-- ```
-- :lua require"jester".run_last()
-- ```

--

-- Restore last session
-- vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})

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
	format_on_save = { timeout_ms = 500, lsp_fallback = true }, -- format on save
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
				-- ["?"] = {
				-- 	function(state)
				-- 		local node = state.tree:get_node()
				-- 		print(node.name)
				-- 	end,
				-- 	desc = "print name",
				-- 	nowait = true,
				-- },
				-- ["i"] = {
				-- 	command = function(state)
				-- 		local node = state.tree:get_node()
				-- 		print(node.name)
				-- 	end,
				-- 	desc = "print name",
				-- 	nowait = true,
				-- },
				["o"] = {
					command = "open",
					nowait = true,
				},
				["O"] = {
					"open",
					nowait = true,
				},
			},
		},
	},
	-- todo: open if no buffer is active
	-- todo: pressing tab should focus on active buffer
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree left reveal_force_cwd<cr>", { desc = "Shows Neotree in current file" })
vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle", { desc = "Toggles Neotree" })

-- [[ mini.pairs ]]
-- https://github.com/echasnovski/mini.pairs
require("mini.pairs").setup({
	-- todo
	-- mappings = {
	--   ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
	--   ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
	--   ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
	--
	--   [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
	--   [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
	--   ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
	--
	--   ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
	--   ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
	--   ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
	-- },
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),

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

-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

require("fine-cmdline").setup({
	cmdline = {
		enable_keymaps = true,
		smart_history = true,
		prompt = ": ",
	},
	popup = {
		position = {
			row = "30%",
			col = "50%",
		},
		size = {
			width = "60%",
		},
		border = {
			style = "rounded",
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
})

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
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
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
		auto_install = false,

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

-- [[ configure ]]
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

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	-- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	-- nmap('<leader>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
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

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
