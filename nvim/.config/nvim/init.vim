set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc

""""""""""""""
" misc
""""""""""""""
let g:do_filetype_lua = 1
lua << EOF
vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "None", ctermfg = "None" })
vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = "None", ctermfg = "None" })
EOF

""""""""""""""
" CMP SETUP
""""""""""""""
lua << EOF
  local cmp = require('cmp')
  -- local luasnip = require("luasnip")
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
      -- { name = 'luasnip' },
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
EOF

""""""""""""""
"" LUASNIP SETUP
""""""""""""""
" lua << EOF
" require("luasnip.loaders.from_vscode").lazy_load()
" EOF

"""""""""""""""""
" NVIM-UFO SETUP
"""""""""""""""""
lua << EOF
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
          capabilities = capabilities
          -- you can add other fields for setting up lsp server in this table
      })
  end
  require('ufo').setup()
EOF

"""""""""""""""""""""""""""""""""""""""
"" Disable inline buffer error messages
"""""""""""""""""""""""""""""""""""""""
lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = false
    }
)
EOF


"""""""""""""""
"" Dirbuf
"""""""""""""""
" lua << EOF
"   vim.g.mapleader = ','
"   vim.keymap.set('n', '<leader>fc', ':Dirbuf<Cr>')
" EOF

""""""
" OIL
""""""
lua << EOF
require("oil").setup()
vim.keymap.set("n", "<leader>fc", require("oil").open, { desc = "Open parent directory"  })
EOF

""""""""""""""
" Competitest
""""""""""""""
lua << EOF
require('competitest').setup()
EOF

"""""""""""""""
"" Diagonostics 
"""""""""""""""
lua << EOF
-- Location information about the last message printed. The format is
-- `(did print, buffer number, line number)`.
local last_echo = { false, -1, -1 }

-- The timer used for displaying a diagnostic in the commandline.
local echo_timer = nil

-- The timer after which to display a diagnostic in the commandline.
local echo_timeout = 250

-- The highlight group to use for warning messages.
local warning_hlgroup = 'WarningMsg'

-- The highlight group to use for error messages.
local error_hlgroup = 'ErrorMsg'

-- If the first diagnostic line has fewer than this many characters, also add
-- the second line to it.
local short_line_limit = 20

-- Shows the current line's diagnostics in a floating window.
function show_line_diagnostics()
  vim
    .lsp
    .diagnostic
    .show_line_diagnostics({ severity_limit = 'Warning' }, vim.fn.bufnr(''))
end

-- Prints the first diagnostic for the current line.
function echo_diagnostic()
  if echo_timer then
    echo_timer:stop()
  end

  echo_timer = vim.defer_fn(
    function()
      local line = vim.fn.line('.') - 1
      local bufnr = vim.api.nvim_win_get_buf(0)

      if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line then
        return
      end

      local diags = vim
        .lsp
        .diagnostic
        .get_line_diagnostics(bufnf, line, { severity_limit = 'Warning' })

      if #diags == 0 then
        -- If we previously echo'd a message, clear it out by echoing an empty
        -- message.
        if last_echo[1] then
          last_echo = { false, -1, -1 }

          vim.api.nvim_command('echo ""')
        end

        return
      end

      last_echo = { true, bufnr, line }

      local diag = diags[1]
      local width = vim.api.nvim_get_option('columns') - 15
      local lines = vim.split(diag.message, "\n")
      local message = lines[1]
      local trimmed = false

      if #lines > 1 and #message <= short_line_limit then
        message = message .. ' ' .. lines[2]
      end

      if width > 0 and #message >= width then
        message = message:sub(1, width) .. '...'
      end

      local kind = 'warning'
      local hlgroup = warning_hlgroup

      if diag.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
        kind = 'error'
        hlgroup = error_hlgroup
      end

      local chunks = {
        { kind .. ': ', hlgroup },
        { message }
      }

      vim.api.nvim_echo(chunks, false, {})
    end,
    echo_timeout
  )
end
EOF
autocmd CursorMoved * :lua echo_diagnostic()

" lua << EOF
" -- You will likely want to reduce updatetime which affects CursorHold
" -- note: this setting is global and should be set only once
" vim.o.updatetime = 250
" vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]
" EOF


"""""""""""""""
"" Treesitter 
"""""""""""""""
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "rust", "cpp", "java", "python", "javascript", "html", "vim"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}
EOF

""""""""""""""""""
"" Which key
""""""""""""""""""
lua << EOF
require "which-key".setup {
  window = {
    border = "single", 
  }
}
EOF

""""""""""""""""""""
"" Mason + Nav Buddy
""""""""""""""""""""
lua << EOF

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

EOF

" lua << EOF
" require("null-ls").setup({
"     sources = {
"         require("null-ls").builtins.diagnostics.vale,
"     },
" })
" EOF

"""""""""""""""
"" inc rename
"""""""""""""""
lua << EOF
require("inc_rename").setup()
vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
  end, { expr = true  })
EOF

"""""""""""""""
" Nvim Autopairs
"""""""""""""""
lua << EOF
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
EOF

"""""""""""""
"" SNIPRUN 
"""""""""""""
lua << EOF
require'sniprun'.setup({
  selected_interpreters = {},     --# use those instead of the default for the current filetype
  repl_enable = {},               --# enable REPL-like behavior for the given interpreters
  repl_disable = {},              --# disable REPL-like behavior for the given interpreters

  interpreter_options = {         --# interpreter-specific options, see doc / :SnipInfo <name>

    --# use the interpreter name as key
    GFM_original = {
      use_on_filetypes = {"markdown.pandoc"}    --# the 'use_on_filetypes' configuration key is
                                                --# available for every interpreter
    },
    Python3_original = {
        error_truncate = "auto"         --# Truncate runtime errors 'long', 'short' or 'auto'
                                        --# the hint is available for every interpreter
                                        --# but may not be always respected
    }
  },      

  --# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
  --# to filter only sucessful runs (or errored-out runs respectively)
  display = {
    -- "Classic",                    --# display results in the command-line  area
    -- "VirtualTextOk",              --# display ok results as virtual text (multiline is shortened)

    -- "VirtualText",             --# display results as virtual text
    -- "TempFloatingWindow",      --# display results in a floating window
    -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
    "Terminal",                --# display results in a vertical split
    -- "TerminalWithCode",        --# display results and code history in a vertical split
    -- "NvimNotify",              --# display with the nvim-notify plugin
    -- "Api"                      --# return output to a programming interface
  },

  live_display = { "VirtualTextOk" }, --# display mode used in live_mode

  display_options = {
    terminal_scrollback = vim.o.scrollback, --# change terminal display scrollback lines
    terminal_line_number = false, --# whether show line number in terminal window
    terminal_signcolumn = false,  --# whether show signcolumn in terminal window
    terminal_persistence = true,  --# always keep the terminal open (true) or close it at every occasion (false)
    terminal_width = 45,          --# change the terminal display option width
    notification_timeout = 5      --# timeout for nvim_notify output
  },

  --# You can use the same keys to customize whether a sniprun producing
  --# no output should display nothing or '(no output)'
  show_no_output = {
    "Classic",
    "TempFloatingWindow",      --# implies LongTempFloatingWindow, which has no effect on its own
  },

  --# customize highlight groups (setting this overrides colorscheme)
  snipruncolors = {
    SniprunVirtualTextOk   =  {bg="#66eeff",fg="#000000",ctermbg="Cyan",cterfg="Black"},
    SniprunFloatingWinOk   =  {fg="#66eeff",ctermfg="Cyan"},
    SniprunVirtualTextErr  =  {bg="#881515",fg="#000000",ctermbg="DarkRed",cterfg="Black"},
    SniprunFloatingWinErr  =  {fg="#881515",ctermfg="DarkRed"},
  },

  live_mode_toggle  = 'off',      --# live mode toggle, see Usage - Running for more info   

  --# miscellaneous compatibility/adjustement settings
  inline_messages = false,    --# boolean toggle for a one-line way to display messages
                              --# to workaround sniprun not being able to display anything

  borders = 'single',         --# display borders around floating windows
                              --# possible values are 'none', 'single', 'double', or 'shadow'
})
EOF

""""""""""""""""
"" lsp signature
""""""""""""""""
lua << EOF
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
EOF
