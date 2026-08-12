--
-- Editing: motions, text objects, pairs, formatting, treesitter
--

return {
  -- Text objects
  { "kana/vim-textobj-user" },
  { "julian/vim-textobj-variable-segment", dependencies = { "kana/vim-textobj-user" } },

  -- CamelCaseMotion
  -- NOTE: this overrides default vim behavior
  {
    "bkad/CamelCaseMotion",
    config = function()
      for _, motion in ipairs({ "w", "b", "e", "ge" }) do
        vim.keymap.set({ "n", "x", "o" }, motion, "<Plug>CamelCaseMotion_" .. motion, { silent = true })
      end
    end,
  },

  -- Auto detect and use the indentation of a file when opened
  {
    "timakro/vim-yadi",
    config = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("UserDetectIndent", { clear = true }),
        command = "DetectIndent",
      })
    end,
  },

  { "machakann/vim-sandwich" },
  { "godlygeek/tabular" },
  { "sbdchd/neoformat" },

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

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ts = require("nvim-treesitter")

      local ensure_installed = { "c", "lua", "rust", "cpp", "java", "python", "javascript", "html", "vim" }
      local already_installed = ts.get_installed()
      local to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()
      if #to_install > 0 then
        ts.install(to_install)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
        desc = "Try to enable tree-sitter syntax highlighting",
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
