local map = vim.keymap.set

-- Utils
map("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Save the file" })

-- Just to beginning and end of lines easier. From http://vimbits.com/bits/16
map("x", "H", "^", { desc = "Beginning of line" })
map("x", "L", "$", { desc = "End of line" })

map("n", "U", "<C-r>", { desc = "Redo" }) -- Redo

-- Git
map("n", "<leader>gm", "<CMD>Neogit<CR>", { desc = "[G]it [M]enu" })
map("n", "gm", "<CMD>Neogit<CR>", { desc = "[G]it [M]enu" })
map("n", "<leader>gb", "<cmd>GitBlameToggle<cr>", { desc = "Toggle [G]it [B]lame" })

-- Diagnostic ("Problems" from IDE) keymaps
map("n", "<leader>p", vim.diagnostic.goto_next, { desc = "Next [P]roblem" })
map("n", "<leader>P", vim.diagnostic.goto_prev, { desc = "Previous [P]roblem" })

-- Floating cmd line
-- map("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })

-- map("n", "<A-p>", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("n", "<A-p>", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Resize windows using option + arrow keys
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move between windows using option + hjkl
map("n", "<A-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<A-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<A-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<A-l>", "<C-w>l", { desc = "Move to right window" })

-- [[ Bufferline ]]
map("n", "<S-l>", "<cmd>BufferNext<cr>", { desc = "Next buffer" })
map("n", "<S-x>", "<cmd>BufferNext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>BufferPrevious<cr>", { desc = "Prev buffer" })
map("n", "<S-z>", "<cmd>BufferPrevious<cr>", { desc = "Prev buffer" })
map("n", "<A-w>", "<cmd>BufferClose<cr>", { desc = "Close buffer" })
map("n", "<A-s-w>", "<cmd>BufferRestore<cr>", { desc = "Restore Buffer" })
map("n", "<C-p>", "<Cmd>BufferPick<CR>", { desc = "Pick buffer" })
map("n", "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", { desc = "Close all buffers but current" })
-- nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
-- nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
-- nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
-- nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>

-- Toggleterm
-- TODO: this does not work good
map("n", "<leader>tl", ":ToggleTerm size=40 direction=vertical name=desktop<CR>", { desc = "Toggle terminal" })
-- :ToggleTerm size=40 dir=~/Desktop direction=horizontal name=desktop

-- Runs the current curl under the cursor
map("n", "<leader>hc", "<Plug>RestNvim", { desc = "[H]ttp [c]ursor" })

-- Turbolog like .cl in webstorm
map("n", "<leader>cl", "<cmd>lua require('logsitter').log()<cr>", { desc = "[L]og" })

-- Scroll up and down
map("n", "<ScrollWheelUp>", "<C-y>", { noremap = true })
map("n", "<ScrollWheelDown>", "<C-e>", { noremap = true })

-- Scratchpad
map("n", "<leader>sn", "<cmd>Scratch<cr>")
map("n", "<leader>so", "<cmd>ScratchOpen<cr>")

-- Run nearest test(s) under the cursor
map("n", "<leader>jc", ':lua require"jester".run()<CR>', { desc = "[J]est run [C]ursor" })

-- Run current file
map("n", "<leader>jf", ':lua require"jester".run_file()<CR>', { desc = "[J]est run [F]ile" })

-- Run last test(s)
map("n", "<leader>jl", ':lua require"jester".run_last()<CR>', { desc = "[J]est run [L]ast" })

-- TODO Install DAP
-- Debug nearest test(s) under the cursor
-- :lua require"jester".debug()
-- Debug current file
-- :lua require"jester".debug_file()
-- Debug last test(s)
-- :lua require"jester".debug_last()
