--
--  Neovim config by Mathew Han
--
--  Sources ~/.vimrc to pick up the shared vim config + vim-plug plugins
--  (~/.vim/plugged), then layers Neovim-only plugins on top via lazy.nvim
--  (specs in lua/plugins/).
--

vim.g.mapleader = ","

require("options")
require("keymaps")

-- Shared vim config and vim-plug plugins
vim.cmd([[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  source ~/.vimrc
]])

-- plugins.vim leaves the colorscheme blank for nvim; set it now that
-- everforest (from ~/.vim/plugged) is on the runtimepath.
vim.cmd.colorscheme("everforest")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  performance = {
    rtp = {
      -- Don't reset the runtimepath; the vim-plug plugins sourced from
      -- ~/.vimrc must stay on it.
      reset = false,
    },
  },
})
