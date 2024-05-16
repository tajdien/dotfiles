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
		config = function()
			require("rest-nvim").setup({
				client = "curl",
				env_file = ".env",
				env_pattern = "\\.env$",
				env_edit_command = "tabedit",
				encode_url = true,
				skip_ssl_verification = false,
				custom_dynamic_variables = {},
				logs = {
					level = "info",
					save = true,
				},
				result = {
					split = {
						horizontal = false,
						in_place = false,
						stay_in_current_window_after_split = true,
					},
					behavior = {
						decode_url = true,
						show_info = {
							url = true,
							headers = true,
							http_info = true,
							curl_command = true,
						},
						statistics = {
							enable = true,
							---@see https://curl.se/libcurl/c/curl_easy_getinfo.html
							stats = {
								{ "total_time", title = "Time taken:" },
								{ "size_download_t", title = "Download size:" },
							},
						},
						formatters = {
							json = "jq",
							html = function(body)
								if vim.fn.executable("tidy") == 0 then
									return body, { found = false, name = "tidy" }
								end
								local fmt_body = vim.fn
									.system({
										"tidy",
										"-i",
										"-q",
										"--tidy-mark",
										"no",
										"--show-body-only",
										"auto",
										"--show-errors",
										"0",
										"--show-warnings",
										"0",
										"-",
									}, body)
									:gsub("\n$", "")

								return fmt_body, { found = true, name = "tidy" }
							end,
						},
					},
				},
				highlight = {
					enable = true,
					timeout = 750,
				},
			})
		end,
		keys = {
			{ "<leader>hc", "<CMD>Rest run<CR>", desc = "Rest: [H]ttp [c]ursor" },
		},
	},

	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure()
		end,
	},
}

return M
