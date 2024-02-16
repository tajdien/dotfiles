-- Copy the path to clipboard
function copy_path_to_root()
	local current_file = vim.fn.expand("%:p")
	local root_dir = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null || echo "/path/to/your/root"')
	local relative_path = current_file:gsub(root_dir, "")
	local clipboard_content = relative_path:gsub("/", "\\/")
	vim.fn.system("echo " .. vim.fn.shellescape(clipboard_content) .. " | pbcopy")
	print("Path copied to clipboard: " .. clipboard_content)
end

vim.api.nvim_set_keymap("n", "<leader>cp", [[:lua copy_path_to_root()<CR>]], { noremap = true, silent = true })
