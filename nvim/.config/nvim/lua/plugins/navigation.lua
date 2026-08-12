--
-- File finding, browsing and window/project navigation
--

-- fzf, fzf.vim and vim-tmux-navigator are shared with vim (loaded from
-- ~/.vim/plugged via lua/vim-plug.lua); their config lives there too.

return {
  { "ibhagwan/fzf-lua" },

  -- File browsers
  {
    "stevearc/oil.nvim",
    dependencies = { "ingur/fzf-oil.nvim", "ibhagwan/fzf-lua" },
    config = function()
      local fzf_oil = require("fzf-oil")
      require("oil").setup({
        float = fzf_oil.float,
        preview_win = fzf_oil.preview_win,
      })

      local browser = fzf_oil.setup()
      vim.keymap.set("n", "<leader>ff", browser.browse, { desc = "File browser" })
    end,
  },
  {
    "HuntFeng/filebuf.nvim",
    config = function()
      require("filebuf").setup({
        -- Move deleted files to a /tmp/filebuf_trash directory instead of removing them
        permanent_delete = false,

        -- Auto-focus the file you were editing before opening filebuf
        auto_focus_current_file = true,

        -- Show git status indicators
        git_status = true,

        -- Show hidden (dot) files by default
        show_hidden = false,

        -- Respect .gitignore / .ignore patterns
        respect_ignore = true,

        -- Confirm operations before saving
        save_confirmation = true,

        -- Use filebuf instead of netrw when opening directories
        hijack_netrw = true,

        -- Default sort method, can change with FilebufSortMethod <method>
        sort_method = "type",

        -- Customize or disable keymaps (set to false to disable)
        keymaps = {
          fold_open = "zo",
          fold_close = "zc",
          fold_toggle = "za",
          fold_open_recursive = "zO",
          fold_open_all = "zR",
          fold_close_all = "zM",
          open_file = "gf",
          open_or_toggle = "<CR>",
          toggle_preview = "K",
          toggle_hidden = "gh",
          close_filebuf = "q",
        },
      })
      vim.keymap.set("n", "<leader>fm", ":Filebuf<cr>", { desc = "File browser" })
    end,
  },

  -- Workspaces / project roots
  {
    "natecraddock/workspaces.nvim",
    dependencies = { "ibhagwan/fzf-lua" },
    opts = {
      hooks = {
        open = { "FzfLua files" },
      },
    },
  },
  {
    "nvim-mini/mini.nvim",
    branch = "stable",
    config = function()
      require("mini.misc").setup()
      MiniMisc.setup_auto_root()
    end,
  },

  {
    "error311/wayfinder.nvim",
    config = function()
      require("wayfinder").setup({
        layout = {
          width = 0.88,
          height = 0.72,
        },
      })
      vim.keymap.set("n", "<leader>wf", "<Plug>(WayfinderOpen)", { desc = "Wayfinder" })
    end,
  },
}
