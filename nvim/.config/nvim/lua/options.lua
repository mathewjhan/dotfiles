--
-- Options (ported from vimrc.d/general.vim and vimrc.d/interface.vim)
--

local opt = vim.opt

-- General
opt.history = 500

-- Files, backups and undo
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Keep undo history in the pre-existing ~/.vim/undo directory
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undo")

-- Text, tab and indent related
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 4
opt.smartindent = true
opt.wrap = true
opt.linebreak = true

-- Behavior when switching between buffers
opt.switchbuf = { "useopen", "usetab", "newtab" }
opt.showtabline = 2

-- Interface
opt.scrolloff = 7
opt.wildmode = "longest:full,full"
opt.wildignore = { "*.o", "*~", "*.pyc", "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.DS_Store" }
opt.cmdheight = 2
opt.whichwrap:append("<,>,h,l")
opt.ignorecase = true
opt.smartcase = true
opt.lazyredraw = true
opt.showmatch = true
opt.matchtime = 2
opt.timeoutlen = 500
opt.number = true
opt.relativenumber = true
opt.fileformats = { "unix", "dos", "mac" }
opt.laststatus = 3 -- global statusline
opt.termguicolors = true

opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "context:12",
  "algorithm:histogram",
  "linematch:200",
  "indent-heuristic",
  "iwhite", -- I toggle this one, it doesn't fit all cases.
}

--
-- Autocmds
--

local augroup = vim.api.nvim_create_augroup("UserOptions", { clear = true })

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Autoresize splits when the window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  command = "wincmd =",
})

-- Delete trailing white space on save, useful for some filetypes ;)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = { "*.txt", "*.js", "*.py", "*.wiki", "*.sh", "*.coffee" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    local old_query = vim.fn.getreg("/")
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
    vim.fn.setreg("/", old_query)
  end,
})

-- Clean floats for any colorscheme (mirrors the old init.lua MISC section)
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "None", ctermfg = "None" })
    vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = "None", ctermfg = "None" })
  end,
})
