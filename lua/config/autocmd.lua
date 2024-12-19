-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
-- 	command = "silent! EslintFixAll",
-- 	group = vim.api.nvim_create_augroup("MyAutocmdsJavaScripFormatting", {}),
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
