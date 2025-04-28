local M

M = {

  {
    -- LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      "saghen/blink.cmp",
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
        volar = {
          filetypes = { "vue" },
        },
        azure_pipelines_ls = {
          filetypes = { "yml", "yaml" },
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                "/azure-pipeline*.y*l",
                "/*.azure*",
                "Azure-Pipelines/**/*.y*l",
                "pipelines/**/*.y*l",
              },
            },
          },
        },
        eslint = {
          code_actions = {
            apply_on_save = {
              enable = true,
              types = { "directive", "problem", "suggestion", "layout" },
            },
          },
        },
        -- html = { filetypes = { 'html', 'twig', 'hbs'} },

        lua_ls = {
          Lua = {
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "$VIMRUNTIME",
                "$XDG_DATA_HOME/nvim/lazy",
                "${3rd}/luv/library",
              }
            },
            diagnostics = { disable = { "missing-fields" } }, -- disables "missing-fields" warning
          },
        },
      }

      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("gd", require("definition-or-references").definition_or_references, "[G]oto [D]efinition")

        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- TODO: Replace with Snacks.nvim
        -- nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        -- nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        -- nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        -- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        -- nmap("<leader>ss", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- Rename
        nmap("<leader>re", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- TODO this looks very with dracula, add border around it
        -- see here https://github.com/jdhao/nvim-config/blob/master/lua/config/lsp.lua#L177-L179
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
        nmap("<leader>=", "<cmd>Format<CR>", "Format buffer")
      end

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            -- capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          })
        end,
      })
    end,
  },

  -- JetBrains like go-to-definition
  {
    "KostkaBrukowa/definition-or-references.nvim",
    config = function()
      require("definition-or-references").setup({
        on_references_result = handle_references_response,
      })
    end,
  },
}

return M
