set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc

""""""""""""""
" CMP SETUP
""""""""""""""
lua <<EOF
  local cmp = require 'cmp'
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
  end
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ["<C-Space>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
            return vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
          end

          vim.fn.feedkeys(t("<C-n>"), "n")
        elseif check_back_space() then
          vim.fn.feedkeys(t("<cr>"), "n")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.complete_info()["selected"] == -1 and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
          vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.fn.feedkeys(t("<ESC>:call UltiSnips#JumpForwards()<CR>"))
        elseif vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t("<C-n>"), "n")
        elseif check_back_space() then
          vim.fn.feedkeys(t("<tab>"), "n")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.fn.feedkeys(t("<C-R>=UltiSnips#JumpBackwards()<CR>"))
        elseif vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t("<C-p>"), "n")
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
      { name = 'ultisnips' },
    },
  }
EOF


""""""""""""""
" COMPE SETUP
""""""""""""""
" lua << EOF
" -- Compe setup
" require'compe'.setup {
"   enabled = true;
"   autocomplete = true;
"   debug = false;
"   min_length = 1;
"   preselect = 'enable';
"   throttle_time = 80;
"   source_timeout = 200;
"   incomplete_delay = 400;
"   max_abbr_width = 100;
"   max_kind_width = 100;
"   max_menu_width = 100;
"   documentation = true;
" 
"   source = {
"     path = true;
"     nvim_lsp = true;
"   };
" }
" 
" local t = function(str)
"   return vim.api.nvim_replace_termcodes(str, true, true, true)
" end
" 
" local check_back_space = function()
"     local col = vim.fn.col('.') - 1
"     if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
"         return true
"     else
"         return false
"     end
" end
" 
" -- Use (s-)tab to:
" --- move to prev/next item in completion menuone
" --- jump to prev/next snippet's placeholder
" _G.tab_complete = function()
"   if vim.fn.pumvisible() == 1 then
"     return t "<C-n>"
"   elseif check_back_space() then
"     return t "<Tab>"
"   else
"     return vim.fn['compe#complete']()
"   end
" end
" _G.s_tab_complete = function()
"   if vim.fn.pumvisible() == 1 then
"     return t "<C-p>"
"   else
"     return t "<S-Tab>"
"   end
" end
" 
" vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
" vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
" vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
" vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
" 
" --This line is important for auto-import
" vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
" vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
" EOF

"""""""""""""""""""""""""""""""""""""""
" Disable inline buffer error messages
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
" Diagonostics 
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


"""""""""""""""
" Treesitter 
"""""""""""""""
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}
EOF

"""""""""""""""
" LSP Config
"""""""""""""""
lua << EOF
local nvim_lsp = require 'lspconfig'
local servers = { 'pyright', 'clangd', 'jdtls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
EOF

"""""""""""""""
" bufresize 
"""""""""""""""
lua << EOF
local opts = { noremap=true, silent=true }
require("bufresize").setup({
    register = {
        keys = {
            { "n", "<C-w><", "30<C-w><", opts },
            { "n", "<C-w>>", "30<C-w>>", opts },
            { "n", "<C-w>+", "10<C-w>+", opts },
            { "n", "<C-w>-", "10<C-w>-", opts },
            { "n", "<C-w>_", "<C-w>_", opts },
            { "n", "<C-w>=", "<C-w>=", opts },
            { "n", "<C-w>|", "<C-w>|", opts },
        },
        trigger_events = { "BufWinEnter", "WinEnter" },
    },
    resize = {
        keys = {},
        trigger_events = { "VimResized" },
    },
})
EOF
