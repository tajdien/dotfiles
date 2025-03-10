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
      undo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "u",
        map = "undo",
        opts = {},
      },
      redo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "U",
        map = "redo",
        opts = {},
      },
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
      { "<leader>cl", "<cmd>lua require('logsitter').log()<cr>", desc = "[L]og" }
    }
  },

  -- copilot
  { "github/copilot.vim" },

  -- show which keybinds are available
  {
    "folke/which-key.nvim",
    config = function()
      local whichKey = require("which-key")
      whichKey.register({
        ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
        ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
        ["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
        ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
      })
    end,
  },

  -- Session management
  {
    'rmagatti/auto-session',
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    }
  },

  -- Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  -- Lua package manager
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },

  -- Render diagnostics in multiple lines
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup()
    end
  },

  -- Obsidian functionality
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    -- ft = "markdown", -- settings this loads obsidian for all markdown files
    event = {
      'BufReadPre ' .. vim.fn.expand '~' .. '/Documents/Vault/**.md',
      'BufNewFile ' .. vim.fn.expand '~' .. '/Documents/Vault/**.md',
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
      }
    },
  },

  -- Open 'other' files
  {
    'rgroli/other.nvim',
    opts = {
      mappings = {
        "react",
      }
    },
    keys = {
      { "<leader>so", "<cmd>:Other<CR>", desc = "[O]ther" }
    }
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = { width = vim.api.nvim_win_get_width(0) - 4 },
      settings = { save_on_toggle = true }
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
