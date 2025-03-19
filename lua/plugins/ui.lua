local M

M = {
  -- UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = false,        -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true,            -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
      routes = {
        { view = "notify",                                   filter = { event = "msg_showmode" } }, -- show "recording macro"
        { filter = { event = "msg_show", find = "written" }, opts = { skip = true } },              -- skip "write" message on save
      },
    },
    -- stylua: ignore
    keys = {
      { '<S-Enter>',  function() require('noice').redirect(tostring(vim.fn.getcmdline())) end, mode = 'c',                   desc = 'Redirect Cmdline' },
      { '<leader>nl', function() require('noice').cmd('last') end,                             desc = 'Noice [L]ast Message' },
      { '<leader>nt', function() require('noice').cmd('telescope') end,                        desc = 'Noice [T]elescope' },
      { '<leader>nd', function() require('noice').cmd('dismiss') end,                          desc = 'Noice [D]ismiss' },
      { '<leader>ne', function() require('noice').cmd('errors') end,                           desc = 'Noice [E]rrors' },
    },
  },

  -- FileTree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      {
        "<leader>e",
        "<cmd>Neotree left reveal_force_cwd<cr>",
        desc = "Neo-Tree: Shows Neotree target current file",
      },
      { "<leader>E", "<cmd>Neotree toggle<cr>", desc = "Neo-Tree: Toggles Neotree" },
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        window = {
          mapping_options = {
            noremap = true,
            nowait = false,
          },
          mappings = {
            ["o"] = { command = "open", nowait = true },
            ["O"] = { command = "open", nowait = true },
            -- Change 'o' bindings to have leader
            ["oc"] = "noop",
            ["<leader>oc"] = { command = "order_by_created", nowait = true },
            ["od"] = "noop",
            ["<leader>od"] = { command = "order_by_diagnostics", nowait = true },
            ["og"] = "noop",
            ["<leader>og"] = { command = "order_by_git_status", nowait = true },
            ["om"] = "noop",
            ["<leader>om"] = { command = "order_by_modified", nowait = true },
            ["on"] = "noop",
            ["<leader>on"] = { command = "order_by_name", nowait = true },
            ["os"] = "noop",
            ["<leader>os"] = { command = "order_by_size", nowait = true },
            ["ot"] = "noop",
            ["<leader>ot"] = { command = "order_by_type", nowait = true },
          },
        },
      },
    },
  },

  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",     -- optional: for git status
      "nvim-tree/nvim-web-devicons", -- optional: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = true
    end,
    opts = {
      sidebar_filetypes = {
        ["neo-tree"] = { event = "bufwipeout", text = "Neotree" },
      },
      icons = {
        button = false,
      },
    },
  },

  -- Statusbar
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "dracula",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
        -- lualine_x = { "fileformat", "filetype", require("recorder").recordingStatus },
        lualine_x = { "fileformat", "filetype" },
      },
    },
  },

  -- Edit files in a buffer
  {
    "stevearc/oil.nvim",
    opts = {
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<cr>"] = "actions.select",
        ["gd"] = "actions.select",
        ["o"] = "actions.select",
        ["<c-s>"] = "actions.select_split",
        ["<c-d>"] = "actions.select_vsplit",
        ["<c-t>"] = "actions.select_tab",
        ["<c-p>"] = "actions.preview",
        ["<c-c>"] = "actions.close",
        ["q"] = "actions.close",
        ["esc"] = "actions.close",
        ["<c-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["<bs>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },

      view_options = {
        show_hidden = true,
      },

      preview = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },

      float = {
        padding = 1,
        max_width = 100,
        max_height = 32,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        override = function(conf)
          return conf
        end,
        preview_split = 'right',
      },
    },
    keys = {
      { "-", "<cmd>Oil --float<cr>", desc = "open oil" },
    },
  },
}

return M
