local M

M = {
	{
		-- LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			-- Order is important here
			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup()
			require("neodev").setup({
				library = { plugins = { "neotest" }, types = true },
			})

			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				tsserver = {},
				eslint = {
					{
						bin = "eslint", -- or `eslint_d`
						code_actions = {
							enable = true,
							apply_on_save = {
								enable = true,
								types = { "directive", "problem", "suggestion", "layout" },
							},
							disable_rule_comment = {
								enable = true,
								location = "separate_line", -- or `same_line`
							},
						},
						diagnostics = {
							enable = true,
							report_unused_disable_directives = false,
							run_on = "save", -- or `save`
						},
					},
				},
				-- html = { filetypes = { 'html', 'twig', 'hbs'} },

				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						diagnostics = { disable = { "missing-fields" } }, -- disables "missing-fields" warning
					},
				},
			}

			local on_attach = function(_, bufnr)
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				-- Replaced with plugin (KostkaBrukowa/definition-or-references.nvim) in core.lua
				-- nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				nmap("gd", require("definition-or-references").definition_or_references, "[G]oto [D]efinition")

				-- Lesser used LSP functionality
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				nmap("<leader>ss", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Rename
				nmap("<leader>re", vim.lsp.buf.rename, "[R]e[n]ame")
				nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- TODO this looks very with dracula, add border around it
				-- see here https://github.com/jdhao/nvim-config/blob/master/lua/config/lsp.lua#L177-L179
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

				-- Create a command `:Format` local to the LSP buffer
				-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				-- 	vim.lsp.buf.format()
				-- end, { desc = "Format current buffer with LSP" })
			end

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})
		end,
		-- config = function()
		-- 	local handlers = {
		-- 		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		-- 		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
		-- 	}
		--
		-- 	require("lspconfig").myserver.setup({ handlers = handlers })
		-- end,
	},
}

-- require("mason").setup()
-- require("mason-lspconfig").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return M
