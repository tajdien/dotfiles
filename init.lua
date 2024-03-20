local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

-- Leader set to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.autocmd")
require("config.keymaps")
require("scripts")

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

require("lazy").setup({ { import = "plugins" } })
