local M

M = {
  -- formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        -- typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        yml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        fish = { "fish_indent" },
      },
      -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- format_after_save = { timeout_ms = 500, lsp_fallback = true },
      async = true,
      quiet = true,
    },
  },

  --
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").create_default_mappings()
    end,
  },

  -- Automatically close pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Surround text with brackets, quotes, etc
  -- { "kylechui/nvim-surround", config = true },
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = '<leaderj>ra',        -- Add surrounding in Normal and Visual modes
        delete = '<leader>rd',     -- Delete surrounding
        find = '<leader>rf',       -- Find surrounding (to the right)
        find_left = '<leader>rF',  -- Find surrounding (to the left)
        highlight = '<leader>rh',  -- Highlight surrounding
        replace = '<leader>rr',    -- Replace surrounding
        update_n_lines = '<leader>rn', -- Update `n_lines`j

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }
  },

  -- automatically highlighting text objects
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure()
    end,
  },

  -- -- indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },

  -- Tailwind tools
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    opts = {},
  },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}

return M
