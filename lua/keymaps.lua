local map = vim.keymap.set

-- Utils
map("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Save the file" })

-- Just to beginning and end of lines easier. From http://vimbits.com/bits/16
map({ "n", "x" }, "H", "^", { desc = "Beginning of line" })
map({ "n", "x" }, "L", "$", { desc = "End of line" })

-- Redo
map("n", "U", "<C-r>", { desc = "Redo" })

-- Git
map("n", "<leader>gm", "<CMD>Neogit<CR>", { desc = "[G]it [M]enu" })

-- Diagnostic ("Problems" from IDE) keymaps
map("n", "<leader>p", vim.diagnostic.goto_next, { desc = "Next [P]roblem" })
map("n", "<leader>P", vim.diagnostic.goto_prev, { desc = "Previous [P]roblem" })

-- Floating cmd line
map("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })

-- TODO: this sounds cool but i need proper keybinds for it
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Jump to previous/next position with []
-- map("n", "<D-[>", "<C-o>", { silent = true, desc = "Jump to previous position" })
-- map("n", "<D-]", "<C-i>", { silent = true, desc = "Jump to next position" })
-- map("n", "<C-[", "<cmd>BufferLineCycleNext<cr>", { noremap = true, desc = "Move to next buffer" })
-- map("n", "<C-]", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, desc = "Move to prev buffer" })
--
-- map("n", "<A-[", "<cmd>BufferLineCycleNext<cr>", { noremap = true, desc = "Move to next buffer" })
-- map("n", "<A-]", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, desc = "Move to prev buffer" })
--
-- map("n", "<D-[", "<cmd>BufferLineCycleNext<cr>", { noremap = true, desc = "Move to next buffer" })
-- map("n", "<C-]", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, desc = "Move to prev buffer" })

-- Resize windows using option + arrow keys
vim.keymap.set("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

map("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Delete other buffers" })
-- require("telescope.builtin").lsp_references

-- Toggleterm
-- TODO: this does not work good
map("n", "<leader>tl", ":ToggleTerm size=40 direction=vertical name=desktop<CR>", { desc = "Toggle terminal" })
-- :ToggleTerm size=40 dir=~/Desktop direction=horizontal name=desktop

-- Runs the current curl under the cursor
map("n", "<leader>hc", "<Plug>RestNvim", { desc = "[H]ttp [c]ursor" })

-- Turbolog like .cl in webstorm
map("n", "<leader>cl", "<cmd>lua require('logsitter').log()<cr>", { desc = "[L]o[g]" })

-- Scroll up and down
map("n", "<ScrollWheelUp>", "<C-y>", { noremap = true })
map("n", "<ScrollWheelDown>", "<C-e>", { noremap = true })

-- jest
-- map("n", "<leader>jf", require("jester").run_file, { desc = "Jest: Run [F]ile" })
--
-- GitBlame
map("n", "<leader>gb", "<cmd>GitBlameToggle<cr>", { desc = "Toggle [G]it [B]lame" })

-- 	{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
-- 	{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
-- 	{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
-- 	{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
-- 	{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
-- 	{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
-- 	{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
-- 	{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },

-- map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle pin" })
-- map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })
-- map("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Delete other buffers" })
-- 	 "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
-- 	{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
-- 	{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
-- 	{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
