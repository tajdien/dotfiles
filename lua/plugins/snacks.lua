local M

M = {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- explorer = { enabled = true }, -- file explorer
      picker = { -- telescope alternative
        enabled = true,
      },
      scroll = { enabled = true }, -- smooth scroll
      bigfile = { enabled = true },
      toggle = { enabled = true },
      -- dashboard = { enabled = true },
      -- indent = { enabled = true },
      -- notifier = { enabled = true },
      -- quickfile = { enabled = true },
      -- scope = { enabled = true },
      -- statuscolumn = { enabled = true },
      -- words = { enabled = true },
    },
    keys = function()
      local Snacks = require("snacks")

      return {
        { "<leader><space>", function() Snacks.picker.smart() end,            desc = "Smart Find Files" },
        { "<leader>sf",      function() Snacks.picker.smart() end,            desc = "Smart Find Files" },
        { "<leader>,",       function() Snacks.picker.buffers() end,          desc = "Buffers" },
        { "<leader>sg",      function() Snacks.picker.grep() end,             desc = "Grep search with args" },
        { "<leader>fg",      function() Snacks.picker.grep() end,             desc = "Grep search with args" },
        { "<leader>sr",      function() Snacks.picker.resume() end,           desc = "Grep search with args" },
        { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,      desc = "LSP Symbols" },
        { "<leader>:",       function() Snacks.picker.command_history() end,  desc = "Command History" },
        { "<leader>sw",      function() Snacks.picker.grep_word() end,        desc = "Visual selection or word", mode = { "n", "x" } },
        { "<leader>sh",      function() Snacks.picker.help() end,             desc = "Help Pages" },
        { "<leader>sc",      function() Snacks.picker.commands() end,         desc = "Search Commands" },
        { "<leader>ff",      function() Snacks.picker.lines() end,            desc = "Buffer Lines" },
        { "gd",              function() Snacks.picker.lsp_definitions() end,  desc = "Goto Definition" },
        { "gD",              function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },

        -- explorer
        -- { "<leader>e",       function() Snacks.explorer.open() end,          desc = "Open File Explorer" },
        -- { "<leader>E",       function() Snacks.explorer.toggle() end,        desc = "Toggle File Explorer" },
      }
    end,
    init = function()
      local Snacks = require("snacks")

      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ul")
          Snacks.toggle.line_number():map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  }
}

return M
