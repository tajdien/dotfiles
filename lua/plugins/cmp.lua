-- local cmp = require("cmp")
-- local luasnip = require("luasnip")
-- require("luasnip.loaders.from_vscode").lazy_load()
-- luasnip.config.setup({})
--
-- cmp.setup({
-- 	snippet = {
-- 		expand = function(args)
-- 			luasnip.lsp_expand(args.body)
-- 		end,
-- 	},
-- 	completion = {
-- 		completeopt = "menu,menuone,noinsert",
-- 	},
-- 	mapping = cmp.mapping.preset.insert({
-- 		["<C-n>"] = cmp.mapping.select_next_item(),
-- 		["<C-p>"] = cmp.mapping.select_prev_item(),
-- 		["<C-d>"] = cmp.mapping.scroll_docs(-4),
-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 		["<C-Space>"] = cmp.mapping.complete({}),
-- 		["<CR>"] = cmp.mapping.confirm({
-- 			behavior = cmp.ConfirmBehavior.Replace,
-- 			-- https://www.reddit.com/r/neovim/comments/xk5uno/nvimcmp_opens_suggestions_when_entering_a_new_line/
-- 			-- deactivated to not suggest on empty line when pressing enter
-- 			-- select = true,
-- 		}),
-- 		-- ["<Tab>"] = cmp.mapping(function(fallback)
-- 		-- 	if cmp.visible() then
-- 		-- 		cmp.select_next_item()
-- 		-- 	elseif luasnip.expand_or_locally_jumpable() then
-- 		-- 		luasnip.expand_or_jump()
-- 		-- 	else
-- 		-- 		fallback()
-- 		-- 	end
-- 		-- end, { "i", "s" }),
-- 		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
-- 		-- 	if cmp.visible() then
-- 		-- 		cmp.select_prev_item()
-- 		-- 	elseif luasnip.locally_jumpable(-1) then
-- 		-- 		luasnip.jump(-1)
-- 		-- 	else
-- 		-- 		fallback()
-- 		-- 	end
-- 		-- end, { "i", "s" }),
-- 	}),
-- 	sources = {
-- 		{ name = "nvim_lsp" },
-- 		{ name = "luasnip" },
-- 	},
-- })
