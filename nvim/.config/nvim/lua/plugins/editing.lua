--
-- Neovim-only editing plugins: pairs and treesitter
--
-- (CamelCaseMotion, textobj-*, vim-yadi, vim-sandwich, tabular and neoformat
-- are shared with vim via ~/.vim/vimrc.d/plugins.vim -- see lua/vim-plug.lua)
--

return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        enable_check_bracket_line = false,
        check_ts = true,
        ts_config = {
          lua = { "string" }, -- it will not add a pair on that treesitter node
          javascript = { "template_string" },
          java = false, -- don't check treesitter on java
        },
      })

      local Rule = require("nvim-autopairs.rule")
      local ts_conds = require("nvim-autopairs.ts-conds")

      -- press % => %% only while inside a comment or string
      npairs.add_rules({
        Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
        Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
      })
    end,
  },

  -- Treesitter (main branch: no `configs` module; install parsers explicitly
  -- and start highlighting via Neovim's built-in vim.treesitter.start())
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function(_, opts)
      -- main branch keeps queries in runtime/, which must be on the rtp
      local plugin_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
      vim.opt.runtimepath:append(plugin_dir .. "/runtime")

      require("nvim-treesitter").install({ "c", "lua", "rust", "cpp", "java", "python", "javascript", "html", "vim" })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
