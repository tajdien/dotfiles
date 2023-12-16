local map = vim.keymap.set

-- Utils
map("n", "<leader>w", ":wa<CR>", { noremap = true, silent = true, desc = "Save the file" })

-- Just to beginning and end of lines easier. From http://vimbits.com/bits/16
map({ "n", "x" }, "H", "^", { desc = "Beginning of line" })
map({ "n", "x" }, "L", "$", { desc = "End of line" })

-- Redo
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Git
map("n", "<leader>gm", "<CMD>Neogit<CR>", { desc = "[G]it [M]enu" })

-- Diagnostic ("Problems" from IDE) keymaps
map("n", "<leader>p", vim.diagnostic.goto_next, { desc = "Next [P]roblem" })
map("n", "<leader>P", vim.diagnostic.goto_prev, { desc = "Previous [P]roblem" })

map("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
