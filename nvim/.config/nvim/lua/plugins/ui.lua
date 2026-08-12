--
-- Neovim-only UI plugins
--
-- (airline, tabline, everforest and the other colorschemes are shared with
-- vim via ~/.vim/vimrc.d/plugins.vim -- see lua/vim-plug.lua)
--

return {
  -- Libraries used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },

  { "shortcuts/no-neck-pain.nvim" },

  -- Folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99 -- Using ufo provider need a large value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      require("ufo").setup()
    end,
  },
}
