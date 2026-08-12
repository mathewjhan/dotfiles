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
}
