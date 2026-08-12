--
-- Neovim-only misc plugins
--
-- (vimtex, markdown-preview, vim-markdown-toc and vim-startuptime are shared
-- with vim via ~/.vim/vimrc.d/plugins.vim -- see lua/vim-plug.lua)
--

return {
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
