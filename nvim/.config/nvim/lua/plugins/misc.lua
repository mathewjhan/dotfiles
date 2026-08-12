--
-- Misc: latex, markdown, competitive programming, habits
--

return {
  { "dstein64/vim-startuptime" },

  { "lervag/vimtex" },

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
  },
  { "mzlogin/vim-markdown-toc" },

  -- Competitive programming
  {
    "xeluxee/competitest.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      popup_ui = {
        total_width = 0.95,
        total_height = 0.95,
        layout = {
          { 4, "tc" },
          { 5, { { 1, "so" }, { 1, "si" } } },
          { 5, { { 1, "eo" }, { 1, "se" } } },
        },
      },
    },
  },
  {
    "kawre/leetcode.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
    opts = {
      theme = {
        ["normal"] = {
          fg = "#FFFFFF",
        },
      },
      lang = "python3",
    },
  },

  { "m4xshen/hardtime.nvim", dependencies = { "MunifTanjim/nui.nvim" }, opts = {} },
}
