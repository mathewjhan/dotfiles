--
-- Colorschemes, statusline and general UI
--

return {
  -- Colorschemes
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("everforest")
    end,
  },
  { "sainnhe/sonokai", lazy = true },
  { "embark-theme/vim", name = "embark", branch = "main", lazy = true },

  -- Statusline / tabline
  {
    "vim-airline/vim-airline",
    init = function()
      vim.g.airline_powerline_fonts = 1
    end,
  },
  { "mkitt/tabline.vim" },

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
