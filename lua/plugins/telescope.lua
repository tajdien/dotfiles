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
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},

		keys = function()
			local builtin = require("telescope.builtin")
			return {
				{
					"<leader>ff",
					builtin.current_buffer_fuzzy_find,
					desc = "Telescope: Fuzzily search in current buffer",
				},
				{ "<leader>sf",      builtin.find_files,                   desc = "Files" },
				{ "<leader><space>", builtin.find_files,                   desc = "Files" },
				{ "<leader>ss",      builtin.symbols,                      desc = "Symbols" },
				{ "<leader>sh",      builtin.help_tags,                    desc = "Help pages" },
				{ "<leader>sw",      builtin.grep_string,                  desc = "Word" },
				{ "<leader>sg",      builtin.live_grep,                    desc = "Grep search with args" },
				{ "<leader>sp",      builtin.diagnostics,                  desc = "Diagnostics" },
				{ "<leader>,",       builtin.buffers,                      desc = "Open buffers" },
				{ "<leader>?",       builtin.oldfiles,                     desc = "Recently opened files" },
				{ "<leader>sr",      builtin.resume,                       desc = "Resume search" },
				{ "<leader>fk",      builtin.keymaps,                      desc = "Keys" },
				{ "<leader>:",       "<cmd>Telescope command_history<cr>", desc = "Command History" },
			}
		end,
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					mappings = {
						i = {
							["<C-f>"] = actions.preview_scrolling_down,
							["<C-b>"] = actions.preview_scrolling_up,
							["<A-]>"] = actions.cycle_history_next,
							["<A-[>"] = actions.cycle_history_prev,
						},
						n = {
							["q"] = actions.close
						}
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
					},
				},
			})

			require('telescope').load_extension("ui-select")
			require('telescope').load_extension("live_grep_args")
			vim.api.nvim_set_keymap("n", "<leader>fg",
				":lua require('telescope').extensions.live_grep_args.live_grep_args({hidden = true})<CR>", { noremap = true })

			-- Enable telescope fzf native
			pcall(require("telescope").load_extension, "fzf")
		end,
	},

	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- JetBrains like go-to-definition
	{
		"KostkaBrukowa/definition-or-references.nvim",
		config = function()
			require("definition-or-references").setup({
				on_references_result = handle_references_response,
			})
		end,
	},
}

return M
