local map = vim.keymap.set

-- Utils
map("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Save the file" })
map("n", "<leader><S-w>", ":wa<CR>", { noremap = true, silent = true, desc = "Save the file" })
map("n", "<C-w>Q", ":q!<CR>", { noremap = true, silent = true, desc = "Force close the file" })

-- Just to beginning and end of lines easier. From http://vimbits.com/bits/16
map("x", "H", "^", { desc = "Beginning of line" })
map("x", "L", "$", { desc = "End of line" })

map("n", "U", "<C-r>", { desc = "Redo" }) -- Redo

-- Diagnostic ("Problems" from IDE) keymaps
map("n", "<leader>p", vim.diagnostic.goto_next, { desc = "Next [P]roblem" })
map("n", "<leader>P", vim.diagnostic.goto_prev, { desc = "Previous [P]roblem" })

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
map("n", "<S-x>", "<cmd>BufferNext<cr>", { desc = "Next buffer" })
map("n", "<S-z>", "<cmd>BufferPrevious<cr>", { desc = "Prev buffer" })
map("n", "<A-w>", "<cmd>BufferClose<cr>", { desc = "Close buffer" })
map("n", "<leader>bc", "<cmd>BufferClose<cr>", { desc = "Close buffer" })
map("n", "<A-s-w>", "<cmd>BufferRestore<cr>", { desc = "Restore Buffer" })
map("n", "<leader>bp", "<Cmd>BufferPick<CR>", { desc = "Pick buffer" })
map("n", "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", { desc = "Close all buffers but current" })
-- nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
-- nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
-- nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
-- nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>

-- Scroll up and down
map("n", "<ScrollWheelUp>", "<C-y>", { noremap = true })
map("n", "<ScrollWheelDown>", "<C-e>", { noremap = true })

-- Do not put the cursor back to selection
map('v', 'v', 'vgy<Esc>', { noremap = true, silent = true })

-- format
map('n', '<leader>=', '<cmd>require ("conform").format { async = true, lsp_fallback = true }<cr>',
	{ noremap = true, silent = true, desc = "Format the file" })

-- TODO Install DAP
-- Debug nearest test(s) under the cursor
-- :lua require"jester".debug()
-- Debug current file
-- :lua require"jester".debug_file()
-- Debug last test(s)
-- :lua require"jester".debug_last()
