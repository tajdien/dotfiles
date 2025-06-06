local M

M = {
  -- Blink
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      sources = {
        -- default = { 'lsp', 'path', 'snippets', 'buffer' },
        default = { 'lsp', 'path', 'buffer' },
      },

      -- experimental signature help support
      signature = { enabled = true },
      --
      completion = {
        accept = {
          -- experimental auto-brackets support
          -- auto_brackets = {
          -- 	enabled = true,
          -- },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          -- check if this conflicts with copilot
          enabled = vim.g.ai_cmp,
        },
      },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" }
  },
}

return M
