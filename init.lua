local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

-- todo
-- 1. alwatys open Neotree
-- 2. make bufferline work with keybindings
-- 3. telescope search
-- 4. vim surround does not work
-- 5. configure dashboard
-- configure shift { } to jumplist ctrl I O
-- only move certain lines when scrolling wiht mousewheel
-- install turbo console.log { ""gaelph/logsitter" },
-- clean up file
-- move plugins to plugin folder

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
-- Here is where we install our plugins.
-- We can configure plugins using the `config` key.
-- We can also configure plugins after the setup call, They will be available at runtime
require("lazy").setup({
	-- theme
	-- { "Mofiqul/dracula.nvim" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
	{ "github/copilot.vim" }, -- copilot
	{ "folke/which-key.nvim", ots = {} }, -- show which keybinds are available
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl" }, -- Intention lines
	{ "stevearc/conform.nvim" }, -- formatter
	{ "justinmk/vim-sneak" }, -- Sneak with S
	{ "tpope/vim-repeat" }, -- Enables repeating of commands from plugins with .
	{ "VonHeikemen/fine-cmdline.nvim", dependencies = { { "MunifTanjim/nui.nvim" } } }, -- floating cmd line
	{ "tzachar/highlight-undo.nvim" }, -- Highlights the last undo and redo
	{ "lewis6991/gitsigns.nvim" }, -- Git signs ( left side shows changes )
	{ "echasnovski/mini.nvim" }, -- Auto close and open pairs like {[ ...
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({})
		end,
	},

	-- todo
	{ "David-Kunz/jester" }, -- jest
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

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},

	-- tabs as tabs ??
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					offsets = {
						{
							filetype = "NvimTree",
							text = "Neotree",
							separator = true,
							text_align = "left",
						},
					},
				},
			})
		end,
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

	-- todo: what was that again?
	{
		"NvChad/nvterm",
		config = function()
			require("nvterm").setup()
		end,
	},

	-- lazy.nvim
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },
	--

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

vim.cmd([[colorscheme catppuccin]]) -- colorscheme

-- todo
-- import and configure plugins
-- local plugin_config = require("plugins")
-- for plugin, config in pairs(plugin_config) do
-- 	require(plugin).setup(config)
-- end

local nvTerm = require("nvterm.terminal")
vim.keymap.set("n", "<leader>t", function()
	nvTerm.toggle("vertical")
end, { noremap = true, desc = "toggles terminal", silent = true })

-- TODO: this sounds cool but i need proper keybinds for it
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Restore last session
vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})

-- [[ Basic Keymaps ]]

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
require("mini.pairs").setup()

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
})

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

-- [[ Telescope KEYBINDS ]]
-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>ff", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 20,
		previewer = true,
	}))
end, { desc = "Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<C-S>o", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sp", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
-- vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
-- vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })

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

	-- Rename
	nmap("<leader>re", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	-- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
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
