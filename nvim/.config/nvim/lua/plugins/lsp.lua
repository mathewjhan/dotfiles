--
-- LSP, completion and snippets
--

return {
  -- LSP + Mason
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- Advertise folding range support for nvim-ufo
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      vim.lsp.config("*", { capabilities = capabilities })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufopts = { noremap = true, silent = true, buffer = args.buf }
          local k, l = vim.keymap.set, vim.lsp
          k("n", "gD", l.buf.declaration, bufopts)
          k("n", "gd", l.buf.definition, bufopts)
          k("n", "gi", l.buf.implementation, bufopts)
          k("n", "<leader>D", l.buf.type_definition, bufopts)
          k("n", "gr", l.buf.references, bufopts)
          k("n", "<leader>ca", l.buf.code_action, bufopts)
          k("v", "<leader>ca", l.buf.code_action, bufopts)
        end,
      })

      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
          },
        },
      })
      -- v2 automatically enables Mason-installed servers via vim.lsp.enable()
      require("mason-lspconfig").setup({
        ensure_installed = {},
      })

      -- Diagnostics
      vim.diagnostic.config({
        virtual_text = false,
        signs = false,
        underline = {
          severity = { min = vim.diagnostic.severity.ERROR },
        },
      })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror" })
    end,
  },

  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
      vim.keymap.set("n", "<leader>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "dcampos/nvim-snippy",
      "dcampos/cmp-snippy",
      "honza/vim-snippets", -- snippet collection, used by snippy
    },
    config = function()
      local cmp = require("cmp")
      local snippy = require("snippy")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            snippy.expand_snippet(args.body)
          end,
        },
        mapping = {
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.close(),

          ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),

          ["<C-n>"] = cmp.mapping(function(fallback)
            if snippy.can_expand_or_advance() then
              snippy.expand_or_advance()
            elseif cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-p>"] = cmp.mapping(function(fallback)
            if snippy.can_jump(-1) then
              snippy.previous()
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-Space>"] = cmp.mapping(function(fallback)
            if snippy.can_expand_or_advance() then
              snippy.expand_or_advance()
            else
              fallback()
            end
          end, { "i", "s" }),
        },

        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "snippy" },
          { name = "nvim_lsp_signature_help" },
        },
        window = {
          documentation = {
            border = "rounded",
            max_width = 120,
            min_width = 60,
            max_height = math.floor(vim.o.lines * 0.3),
            min_height = 1,
          },
        },
      })
    end,
  },
}
