local M

M = {
  -- Git Menu
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",      -- optional
    },
    config = true,
    opts = {
      disable_hint = true
    },
    keys = {
      { "<leader>gm", "<CMD>Neogit<CR>", desc = "Neogit: [G]it [M]enu" },
      { "gm",         "<CMD>Neogit<CR>", desc = "Neogit: [G]it [M]enu" },
    },
  },

  {
    "sindrets/diffview.nvim",
    opts = {
      file_panel = {
        listing_style = "list",
      },
      view = {},
    },
  },

  -- Git signs on the left side
  { "lewis6991/gitsigns.nvim", config = true },

  -- Git shortcuts
  { "tpope/vim-fugitive" },

  {
    "FabijanZulj/blame.nvim",
    cmd = "ToggleBlame",
    -- stylua: ignore
    keys = {
      { '<leader>gb', '<cmd>BlameToggle virtual<CR>', desc = 'Git blame' },
      { '<leader>gB', '<cmd>BlameToggle window<CR>',  desc = 'Git blame (window)' },
    },
    opts = {
      date_format = "%Y-%m-%d %H:%M",
      merge_consecutive = true,
    },
  },
}

return M
