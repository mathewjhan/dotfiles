vim.cmd([[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  source ~/.vimrc
  let g:do_filetype_lua = 1
]])

-- MISC
vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "None", ctermfg = "None" })
vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = "None", ctermfg = "None" })

-- CMP SETUP
local cmp = require('cmp')
local snippy = require("snippy")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end
  },
  mapping = {
    -- ['<C-p>'] = cmp.mapping.select_prev_item(),
    -- ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),

    -- ["<C-Space>"] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),

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
    end, {
      "i",
      "s",
    }),
  }, 

  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'snippy' },
  },
  window = {
    documentation = {
      border = "rounded",
      max_width = 120,
      min_width = 60,
      max_height = math.floor(vim.o.lines * 0.3),
      min_height = 1,
    },
  }
}


-- NVIM-UFO SETUP
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

vim.keymap.set('n', 'z<Cr>', 'za')
vim.keymap.set('n', 'z<Space>', 'zA')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities,
        -- you can add other fields for setting up lsp server in this table
    })
end
require('ufo').setup()

-- Disable inline buffer error messages
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = false
    }
)


-- OIL
require("oil").setup()
vim.keymap.set("n", "<leader>fc", require("oil").open, { desc = "Open parent directory"  })

-- Competitest
require('competitest').setup()


-- Treesitter 
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "rust", "cpp", "java", "python", "javascript", "html", "vim"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}


-- Mason + Nav Buddy
local navbuddy = require("nvim-navbuddy")
navbuddy.setup {
  node_markers = {
      enabled = false,
      icons = {
          leaf = "",
          leaf_selected = "",
          branch = "",
      },
  },
  icons = {
      File          = "",
      Module        = "",
      Namespace     = "",
      Package       = "",
      Class         = "",
      Method        = "",
      Property      = "",
      Field         = "",
      Constructor   = "",
      Enum          = "",
      Interface     = "",
      Function      = "",
      Variable      = "",
      Constant      = "",
      String        = "",
      Number        = "",
      Boolean       = "",
      Array         = "",
      Object        = "",
      Key           = "",
      Null          = "",
      EnumMember    = "",
      Struct        = "",
      Event         = "",
      Operator      = "",
      TypeParameter = "",
  },
}

require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓"
        }
    }
}
mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
    ensure_installed = {},
}

mason_lspconfig.setup_handlers({
  function (server_name)
    require("lspconfig")[server_name].setup {
      on_attach = function(client, bufnr)
              navbuddy.attach(client, bufnr)
      end
    }
  end
})

vim.g.mapleader = ','
vim.keymap.set('n', '<leader>fn', ':Navbuddy<Cr>')


-- inc rename
require("inc_rename").setup()
vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
  end, { expr = true  })

--  Nvim Autopairs
require('nvim-autopairs').setup({
  enable_check_bracket_line = false
})
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')


-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})


-- lsp signature
cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = "debug_log_file_path", -- debug log path
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

-- recommanded:
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key
