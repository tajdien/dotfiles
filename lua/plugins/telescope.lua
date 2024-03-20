local M

-- vim.keymap.set("n", "<leader>ff", function()
-- 	--You can pass additional configuration to telescope to change theme, layout, etc.
-- 	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
-- 		winblend = 20,
-- 		previewer = true,
-- 	}))
-- end, { desc = "Fuzzily search in current buffer" })

M = {
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
		keys = function()
			local builtin = require("telescope.builtin")
			return {
				{
					"<leader>ff",
					builtin.current_buffer_fuzzy_find,
					desc = "Telescope: Fuzzily search in current buffer",
				},
				{ "<leader>sf", builtin.find_files, desc = "Telescope: [S]earch [F]iles" },
				{ "<leader>ss", builtin.symbols, desc = "Telescope: [S]earch [S]ymbols" },
				{ "<leader>sh", builtin.help_tags, desc = "Telescope: [S]earch [H]elp" },
				{ "<leader>sw", builtin.grep_string, desc = "Telescope: [S]earch current [W]ord" },
				{ "<leader>sg", builtin.live_grep, desc = "Telescope: [S]earch by [G]rep" },
				{ "<leader>fg", builtin.live_grep, desc = "Telescope: [S]earch by [G]rep" },
				{ "<leader>sp", builtin.diagnostics, desc = "Telescope: [S]earch [D]iagnostics" },
				{ "<leader><space>", builtin.buffers, desc = "Telescope: [space] Find existing buffers" },
				{ "<leader>?", builtin.oldfiles, desc = "Telescope: [?] Find recently opened files" },
				{ "<leader>sr", builtin.resume, { desc = "Telescope: [S]earch [R]esume" } },
				{ "<leader>fk", builtin.keymaps, { desc = "Telescope: Find [K]eys" } },
			}
		end,
		config = function()
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

			require("telescope").load_extension("ui-select")

			-- Enable telescope fzf native
			pcall(require("telescope").load_extension, "fzf")
		end,
	},

	{ "nvim-telescope/telescope-ui-select.nvim" },
}

return M
