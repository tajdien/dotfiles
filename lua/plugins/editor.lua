local M

M = {
	-- formatter
	{
		"stevearc/conform.nvim",
		opts = {
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
			format_on_save = { timeout_ms = 500 },
			format_after_save = { lsp_fallback = true },
			async = true,
			quiet = true,
		},
	},

	-- Navigate with S
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").create_default_mappings()
		end,
	},

	-- Quickly comment lines/blocks
	{ "numToStr/Comment.nvim", config = true },

	-- Smooth scrolling
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},

	-- Automatically close pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},

	-- Surround text with brackets, quotes, etc
	{ "kylechui/nvim-surround", config = true },

	{
		"rest-nvim/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = true,
		opts = {
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
		},
		keys = {
			{ "<leader>hc", "<Plug>RestNvim", desc = "Rest: [H]ttp [c]ursor" },
		},
	},
}

return M
