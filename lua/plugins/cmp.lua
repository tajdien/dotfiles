local M

M = {
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",         -- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",             -- Adds a number of user-friendly snippetsvim
			"onsails/lspkind.nvim",             -- Format completion items with icons
			"luckasRanarison/tailwind-tools.nvim", -- tailwind utilities
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				window = {
					completion = {
						border = "rounded",
						side_padding = 1,
						scrollbar = false,
					},
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = 50,
						ellipsis_char = "..", -- if the item is too long, use this to truncate
						show_labelDetails = true, -- show labelDetails in menu.
						before = require("tailwind-tools.cmp").lspkind_format,
					}),
				},
				sorting = { -- Very hard to find actual documentation on this
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.recently_used,
						cmp.config.compare.sort_text,
						cmp.config.compare.score,
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
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer",  keyword_length = 5 },
					{ name = "calc" },
					{ name = "path" },
					{ name = "rg",      keyword_length = 5 },
				},
			})

			-- Autocomplete in command line
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}

return M
