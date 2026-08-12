--
-- Mappings (ported from vimrc.d/mappings.vim)
--

local map = vim.keymap.set

-- Fast saving / quitting
map("n", "<leader>w", ":w!<cr>")
map("n", "<leader>q", ":q!<cr>")
map("n", "<leader>z", ":wq<cr>")

-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
vim.cmd([[
  function! VisualSelection() range
      let l:saved_reg = @"
      execute "normal! vgvy"

      let l:pattern = escape(@", "\\/.*'$^~[]")
      let l:pattern = substitute(l:pattern, "\n$", "", "")

      let @/ = l:pattern
      let @" = l:saved_reg
  endfunction
]])
map("x", "*", [[:<C-u>call VisualSelection()<CR>/<C-R>=@/<CR><CR>]], { silent = true })
map("x", "#", [[:<C-u>call VisualSelection()<CR>?<C-R>=@/<CR><CR>]], { silent = true })

-- Count movement for j,k
map("n", "k", function() return vim.v.count == 0 and "gk" or "k" end, { expr = true })
map("n", "j", function() return vim.v.count == 0 and "gj" or "j" end, { expr = true })

-- Centering
map("n", "n", "nzz")
map("n", "p", "pzz")
map("n", "N", "Nzz")
map("n", "P", "Pzz")
map("n", "{", "{zz")
map("n", "}", "}zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Clone current paragraph
map("n", "cp", "yap<S-}>p")

-- Map <Esc> in term mode to exit term
map("t", "<Esc>", [[<C-\><C-n>]])
map("t", "<C-[>", [[<C-\><C-n>]])

-- Toggle line numbers
map("n", "<leader>n", ":set rnu!<cr>")

-- Disable highlight when <leader><cr> is pressed
map({ "n", "x", "o" }, "<leader><cr>", ":noh<cr>", { silent = true })

-- Switch between buffers quickly
map("n", "<leader><leader>", "<C-^>")

-- Smart way to move between windows (overridden by vim-tmux-navigator)
map("n", "<C-j>", "<C-W>j")
map("n", "<C-k>", "<C-W>k")
map("n", "<C-h>", "<C-W>h")
map("n", "<C-l>", "<C-W>l")

-- Don't close window, when deleting a buffer
local function bclose()
  local current = vim.api.nvim_get_current_buf()
  local alternate = vim.fn.bufnr("#")

  if vim.fn.buflisted(alternate) == 1 then
    vim.cmd("buffer #")
  else
    vim.cmd("bnext")
  end

  if vim.api.nvim_get_current_buf() == current then
    vim.cmd("new")
  end

  if vim.fn.buflisted(current) == 1 then
    vim.cmd("bdelete! " .. current)
  end
end
vim.api.nvim_create_user_command("Bclose", bclose, {})

-- Close the current buffer
map("n", "<leader>bd", ":Bclose<cr>:tabclose<cr>gT")

-- Easier copy
map({ "n", "x", "o" }, "<leader>y", '"+y')
map({ "n", "x", "o" }, "<leader>d", '"+d')
map({ "n", "x", "o" }, "<leader>p", '"+p')

-- Close all the buffers
map("n", "<leader>ba", ":bufdo bd<cr>")

map("n", "<leader>l", ":bnext<cr>")
map("n", "<leader>h", ":bprevious<cr>")

-- Useful mappings for managing tabs
map("n", "<leader>tn", ":tabnew<cr>")
map("n", "<leader>to", ":tabonly<cr>")
map("n", "<leader>tc", ":tabclose<cr>")
map("n", "<leader>tm", ":tabmove ")
map("n", "<leader>t<leader>", ":tabnext ")

-- Let 'tl' toggle between this and the last accessed tab
vim.g.lasttab = 1
map("n", "<leader>tl", function()
  vim.cmd("tabn " .. vim.g.lasttab)
end)
vim.api.nvim_create_autocmd("TabLeave", {
  group = vim.api.nvim_create_augroup("UserLastTab", { clear = true }),
  callback = function()
    vim.g.lasttab = vim.fn.tabpagenr()
  end,
})

-- Opens a new tab with the current buffer's path
-- Super useful when editing files in the same directory
map("n", "<leader>te", ':tabedit <c-r>=expand("%:p:h")<cr>/')

-- Switch CWD to the directory of the open buffer
map("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")

-- Remap 0 to first non-blank character
map({ "n", "x", "o" }, "0", "^")

-- Spell checking: pressing ,sc will toggle and untoggle spell checking
map("n", "<leader>sc", ":setlocal spell!<cr>")

-- Replace word under cursor
map("n", "<leader>rr", [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]])

-- Move highlighted block
map("x", "J", ":m '>+1<CR>gv=gv")
map("x", "K", ":m '<-2<CR>gv=gv")

-- Fast movement on homerow
map("n", "J", "<PageDown>zz")
map("n", "K", "<PageUp>zz")

-- Fold toggling
map("n", "z<Cr>", "za")
map("n", "z<Space>", "zA")

-- Toggle paste mode on and off
map("n", "<leader>pp", ":setlocal paste!<cr>")

-- New lines in normal mode, works with numbers
map("n", "<leader>o", [[:<c-u>let b:_=getcurpos()<bar>put!=repeat(nr2char(10), v:count1)<bar>let b:_[1]+=v:count1<bar>call setpos('.', b:_)<bar>unlet b:_<cr>]], { silent = true })
map("n", "<leader>O", [[:<c-u>let b:_=getcurpos()<bar>put=repeat(nr2char(10), v:count1)<bar>call setpos('.', b:_)<bar>unlet b:_<cr>]], { silent = true })
