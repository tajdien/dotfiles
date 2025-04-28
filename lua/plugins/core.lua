local M

M = {
  {
    "maxmx03/dracula.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme dracula]])
    end,
  },

  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      -- your options here
    },
  },

  -- better comments
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },

  -- Highlights the last undo and redo
  {
    "tzachar/highlight-undo.nvim",
    opts = {
      duration = 500,
      highlight_for_count = true,
    },
  },

  {
    "gaelph/logsitter.nvim",
    opts = {
      path_format = "fileonly",
      prefix = "📚",
    },
    keys = {
      { "<leader>cl", "<cmd>lua require('logsitter').log()<cr>", desc = "[L]og" },
    },
  },


  -- show which keybinds are available
  {
    "folke/which-key.nvim",
    config = function()
      local whichKey = require("which-key")
      whichKey.setup({
        preset = "helix",
        notify = false,
      })
    end,
  },

  -- Session management
  {
    "rmagatti/auto-session",
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      lazy_support = true,
      bypass_save_filetypes = { "neotree" },
    },
  },

  -- Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        icons = { '󰲡  ', '󰲣  ', '󰲥  ', '󰲧  ', '󰲩  ', '󰲫  ' },
      }
    },
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        '~/.local/share/nvim/lazy/',
      },
    },
  },

  -- Lua package manager
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },

  -- copilot
  -- { "github/copilot.vim" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          auto_refresh = true,
          layout = {
            position = "right",
          },
          keymap = {
            open = "<C-CR>",
          }
        },
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<Tab>"
          }
        },
        filetypes = {
          yaml = true,
          markdown = true,
          gitcommit = true,
          ["."] = true,
        },
      })
    end,
  },

  -- Render diagnostics in multiple lines
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },

  -- Obsidian functionality
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    -- ft = "markdown", -- settings this loads obsidian for all markdown files
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Vault/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Vault/**.md",
    },
    opts = {
      workspaces = {
        {
          name = "Vault",
          path = "~/documents/Vault",
        },
      },
      ui = {
        enable = false,
      },
    },
  },

  -- Open 'other' files
  {
    "rgroli/other.nvim",
    opts = {
      mappings = {
        "react",
      },
    },
    keys = {
      { "<leader>so", "<cmd>:Other<CR>", desc = "[O]ther" },
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = { width = vim.api.nvim_win_get_width(0) - 4 },
      settings = { save_on_toggle = true },
    },
    keys = function()
      local keys = {
        {
          "<leader>H",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
}

return M
