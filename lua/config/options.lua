local opt = vim.opt
local global = vim.g
local api = vim.api

-- disable netrw for neotree
global.loaded_netrw = 1
global.loaded_netrwPlugin = 1

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.termguicolors = true -- TODO: was das
opt.cursorline = true -- Shows cursor in line

opt.scrolloff = 10 -- Keep lines between cursor

-- obsidian.nvim
-- https://github.com/epwalsh/obsidian.nvim/issues/286
opt.conceallevel = 2

opt.relativenumber = true -- Relative line numbers
opt.number = true -- Show line numbers

-- todo: does not work as i want and i need the smooth scrolling
opt.mousescroll = "ver:1,hor:6" -- Mouse scroll options

opt.hlsearch = false -- Set highlight on search
opt.mouse = "a" -- Enable mouse mode
opt.breakindent = true -- Enable break indent
opt.undofile = true -- Save undo history

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
opt.termguicolors = true

api.nvim_set_option("clipboard", "unnamedplus")

opt.cursorline = true -- Shows cursor in line
