local M

M = {
	-- UI
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim", --[[ "rcarriga/nvim-notify" ]]
		},
		-- stylua: ignore
		keys = {
					{ '<S-Enter>', function() require('noice').redirect(tostring(vim.fn.getcmdline())) end, mode = 'c', desc = 'Redirect Cmdline' },
					{ '<leader>snl', function() require('noice').cmd('last') end, desc = 'Noice Last Message' },
					{ '<leader>snh', function() require('noice').cmd('history') end, desc = 'Noice History' },
					{ '<leader>sna', function() require('noice').cmd('all') end, desc = 'Noice All' },
		},
	},

	-- FileTree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		keys = {
			{
				"<leader>e",
				"<cmd>Neotree left reveal_force_cwd<cr>",
				desc = "Neo-Tree: Shows Neotree target current file",
			},
			{ "<leader>E", "<cmd>Neotree toggle<cr>", desc = "Neo-Tree: Toggles Neotree" },
		},
		opts = {
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
		},
	},

	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- optional: for git status
			"nvim-tree/nvim-web-devicons", -- optional: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = true
		end,
		opts = {
			sidebar_filetypes = {
				["neo-tree"] = { event = "bufwipeout", text = "Neotree" },
			},
			icons = {
				button = false,
			},
		},
	},

	-- Statusbar
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "dracula",
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
				-- lualine_x = { "fileformat", "filetype", require("recorder").recordingStatus },
				lualine_x = { "fileformat", "filetype" },
			},
		},
	},

	-- Edit files in a buffer
	{
		"stevearc/oil.nvim",
		opts = {
			keymaps = {
				["g?"] = "actions.show_help",
				["<cr>"] = "actions.select",
				["gd"] = "actions.select",
				["o"] = "actions.select",
				["<c-s>"] = "actions.select_vsplit",
				["<c-h>"] = "actions.select_split",
				["<c-t>"] = "actions.select_tab",
				["<c-p>"] = "actions.preview",
				["<c-c>"] = "actions.close",
				["q"] = "actions.close",
				["esc"] = "actions.close",
				["<c-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["<bs>"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
			view_options = {
				show_hidden = true,
			},
		},
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "open oil" },
		},
	},
}

return M
