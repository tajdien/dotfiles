local M

M = {
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip", -- Snippet Engine & its associated nvim-cmp source
			"saadparwaiz1/cmp_luasnip", -- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp", -- Adds a number of user-friendly snippetsvim
			"rafamadriz/friendly-snippets",
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

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
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:Pmenu,CursorLine:CmpCursorLine",
						-- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CmpCursorLine,Search:None",
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
