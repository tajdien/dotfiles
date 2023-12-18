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
vim.keymap.set("n", "<A-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase window width" })
