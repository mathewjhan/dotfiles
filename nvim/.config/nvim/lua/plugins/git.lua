--
-- Git and diff tooling
--

return {
  { "tpope/vim-fugitive" },

  { "lewis6991/gitsigns.nvim", opts = {} },

  {
    "sindrets/diffview.nvim",
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        keymaps = {
          view = {
            { "n", "j", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "k", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
          },
          file_panel = {
            { "n", "j", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "k", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
          },
          file_history_panel = {
            { "n", "j", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "k", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
          },
        },
      })

      local function toggle_diffview(cmd)
        local lib = require("diffview.lib")
        if next(lib.views) == nil then
          vim.cmd(cmd)
        else
          vim.cmd("DiffviewClose")
        end
      end

      vim.keymap.set("n", "<leader>gd", function()
        toggle_diffview("DiffviewOpen")
      end, { desc = "DiffView toggle (working tree)" })

      vim.keymap.set("n", "<leader>gD", function()
        toggle_diffview("DiffviewOpen origin/HEAD...HEAD")
      end, { desc = "DiffView toggle (base branch)" })

      vim.keymap.set("n", "<leader>gf", function()
        toggle_diffview("DiffviewFileHistory %")
      end, { desc = "DiffView file history" })
    end,
  },

  -- PR review
  {
    "emrearmagan/atlas.nvim",
    dependencies = { "sindrets/diffview.nvim" },
    opts = {
      pulls = {
        diff = {
          -- Any command that accepts explicit <base>...<head> Git revisions.
          open_cmd = "DiffviewOpen", -- default; for example "DiffviewOpen" or "CodeDiff".

          -- AtlasDiff options; external viewers use their own configuration.
          layout = "inline", -- "inline" or "side-by-side".
          compact = true, -- Start with only changed hunks and surrounding context visible.
          explorer = {
            grouped = true, -- Group changed files by directory.
            hidden = false,
            show_commits = true, -- Initially show commits below changed files.
            width = 40,
            initial_focus = "explorer", -- "explorer" or "diff".
            ignore = { ".git/**", ".jj/**" },
          },
        },
        providers = {
          github = {
            cache_ttl = 300,

            ---@type AtlasGitHubViewConfig[]
            views = {
              {
                name = "My PRs",
                key = "1",
                layout = "plain",
                search = "author:@me sort:updated-desc",
              },
              {
                name = "Team",
                key = "2",
                layout = "compact",
                search = "org:your-org sort:updated-desc",
              },
              {
                name = "Repo",
                key = "3",
                layout = "plain",
                search = "repo:your-org/your-repo",
              },
            },

            bookmarks = {
              key = "S", -- default
              label = "Search", -- default
              items = {
                ["Drafts"] = "is:pr is:draft author:@me",
                ["Recently merged"] = "is:pr is:merged author:@me sort:updated-desc",
                ["Review requested"] = "is:pr is:open review-requested:@me",
              },
            },
          },
        },
      },
    },
  },
}
