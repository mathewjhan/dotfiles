-- Source vim config
vim.cmd([[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  source ~/.vimrc
  let g:do_filetype_lua = 1
]])

local map = function(type, key, value)
	vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

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
    { name = 'nvim_lsp_signature_help' },
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

local keys_on_attach = function(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local k, l, api = vim.keymap.set, vim.lsp, vim.api
    k("n", "gD", l.buf.declaration, bufopts)
    k("n", "gd", l.buf.definition, bufopts)
    k("n", "gi", l.buf.implementation, bufopts)
    k("n", "<leader>D", l.buf.type_definition, bufopts)
    k("n", "gr", l.buf.references, bufopts)
    k("n", "<leader>ca", l.buf.code_action, bufopts)
    k("v", "<leader>ca", l.buf.code_action, bufopts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    keys_on_attach(client, bufnr)
  end,
})


local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities,
        -- you can add other fields for setting up lsp server in this table
    })
end
require('ufo').setup()

-- Competitest
require('competitest').setup{
  popup_ui = {
    total_width = 0.95,
    total_height = 0.95,
    layout = {
        { 4, "tc" },
        { 5, { { 1, "so" }, { 1, "si" } } },
        { 5, { { 1, "eo" }, { 1, "se" } } },
    },
  },
}


-- Treesitter 
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "rust", "cpp", "java", "python", "javascript", "html", "vim"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}


-- Mason
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


lc_cfg = {
  theme = {
    ["normal"] = {
        fg = "#FFFFFF",
    },
  },
  lang = "python3",
}
require'leetcode'.setup(lc_cfg)

require("hardtime").setup()

-- workspaces.nvim
require("workspaces").setup({
    hooks = {
        open = { "FzfLua files" },
    }
})

-- mini.misc
require('mini.misc').setup()
MiniMisc.setup_auto_root()

require("wayfinder").setup({
  layout = {
    width = 0.88,
    height = 0.72,
  },
})

vim.keymap.set("n", "<leader>wf", "<Plug>(WayfinderOpen)", { desc = "Wayfinder" })

-- gitsigns
require('gitsigns').setup()

-- diag
vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = {
      severity = { min = vim.diagnostic.severity.ERROR }
    }
})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [e]rror' })

-- diffview
local actions = require("diffview.actions")
require("diffview").setup({
  keymaps = {
    view = {
      { "n", "j",       actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "k",     actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
    },
    file_panel = {
      { "n", "j",       actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "k",     actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
    },
    file_history_panel = {
      { "n", "j",       actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "k",     actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
    },
  },
})
local function toggle_diffview(cmd)
  local lib = require("diffview.lib")

  if next(lib.views) == nil then
    vim.cmd(cmd)
  else
    vim.cmd("DiffviewClose")
  end
end
vim.keymap.set("n", "<leader>gd", function()
  toggle_diffview("DiffviewOpen")
end, { desc = "DiffView toggle (working tree)" })

vim.keymap.set("n", "<leader>gD", function()
  toggle_diffview("DiffviewOpen origin/HEAD...HEAD")
end, { desc = "DiffView toggle (base branch)" })

vim.keymap.set("n", "<leader>gf", function()
  toggle_diffview("DiffviewFileHistory %")
end, { desc = "DiffView file history" })

vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "context:12",
  "algorithm:histogram",
  "linematch:200",
  "indent-heuristic",
  "iwhite" -- I toggle this one, it doesn't fit all cases.
}
