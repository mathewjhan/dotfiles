--
-- Git and diff tooling
--

-- vim-fugitive is shared with vim (loaded from ~/.vim/plugged via lua/vim-plug.lua)

return {
  { "lewis6991/gitsigns.nvim", opts = {} },

  {
    "dlyongemallo/diffview-plus.nvim",
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        use_icons = true,
        view = {
          default = { layout = "diff2_horizontal" },
          merge_tool = { layout = "diff3_horizontal" },
        },
        file_panel = {
          listing_style = "tree",
          win_config = { position = "left", width = 35 }, -- Use "auto" to fit content
        },
        hooks = {},   -- See :h diffview-config-hooks
        keymaps = {}, -- See :h diffview-config-keymaps
      })
    end
  },

  -- Commit, push, etc
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {},
      picker = {
        sources = {
          gh_issue = {},
          gh_pr = {}
        }
      },
    },
    keys = {
      { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
    },
  },

  -- PR review
  {
    "undont/differ.nvim",
    build = "make go-build",
    config = function()
      require("differ").setup()
    end,
  },

  -- GitHub issues/PRs: browse, create, review, diff
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        picker = "fzf-lua",
        use_local_fs = false, -- use local files on right side of reviews
        reviews = {
          auto_show_threads = true,
          focus = "right", -- focus right buffer on diff open
        },
      })

      -- Search my open PRs in the repo of the current buffer
      vim.keymap.set("n", "<leader>gp", function()
        local repo = require("octo.utils").get_remote_name()
        if not repo or repo == "" then
          vim.notify("octo: no git remote found", vim.log.levels.WARN)
          return
        end
        vim.cmd("Octo search is:pr is:open author:@me repo:" .. repo)
      end, { desc = "My open PRs (this repo)" })
    end,
  },
}
