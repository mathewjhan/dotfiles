--
-- File finding, browsing and window/project navigation
--

-- fzf, fzf.vim and vim-tmux-navigator are shared with vim (loaded from
-- ~/.vim/plugged via lua/vim-plug.lua); their config lives there too.

return {
  {
    "ibhagwan/fzf-lua",
    config = function()
      vim.keymap.set("n", "<leader>ff", function()
        require("fzf-lua").files()
      end, { desc = "Find files" })
    end,
  },

  -- File browsers
  {
    "HuntFeng/filebuf.nvim",
    config = function()
      require("filebuf").setup({
        -- Move deleted files to a /tmp/filebuf_trash directory instead of removing them
        permanent_delete = false,

        -- Auto-focus the file you were editing before opening filebuf
        auto_focus_current_file = true,

        -- Show git status indicators
        git_status = true,

        -- Show hidden (dot) files by default
        show_hidden = false,

        -- Respect .gitignore / .ignore patterns
        respect_ignore = true,

        -- Confirm operations before saving
        save_confirmation = true,

        -- Use filebuf instead of netrw when opening directories
        hijack_netrw = true,

        -- Default sort method, can change with FilebufSortMethod <method>
        sort_method = "type",
      })

      -- filebuf has no float API. Only :Filebuf / <leader>fm open a float;
      -- wrapping filebuf.open itself also intercepts netrw hijack and leaves
      -- a transparent overlay that swallows keys like w/b.
      local filebuf = require("filebuf")
      local orig_open = filebuf.open
      local orig_open_entry = filebuf.open_entry
      local orig_close = filebuf.close

      local float_win ---@type integer|nil
      local origin_win ---@type integer|nil
      local float_group = vim.api.nvim_create_augroup("FilebufFloat", { clear = true })

      local function float_valid()
        return float_win ~= nil and vim.api.nvim_win_is_valid(float_win)
      end

      local function editor_size()
        local width = vim.o.columns
        local height = vim.o.lines - vim.o.cmdheight
        if vim.o.laststatus > 0 then
          height = height - 1
        end
        if vim.o.showtabline == 2 or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1) then
          height = height - 1
        end
        return width, math.max(height, 1)
      end

      local function float_config()
        local columns, lines = editor_size()
        local width = math.max(40, math.floor(columns * 0.8))
        local height = math.max(10, math.floor(lines * 0.8))
        return {
          relative = "editor",
          width = width,
          height = height,
          row = math.floor((lines - height) / 2),
          col = math.floor((columns - width) / 2),
          border = "rounded",
          zindex = 45,
          title = " filebuf ",
          title_pos = "center",
        }
      end

      local function apply_float_hl()
        if not float_valid() then
          return
        end
        -- NormalFloat/FloatBorder are fully transparent in this config, so
        -- use Pmenu instead or the tree is invisible and still eats keys.
        vim.wo[float_win].winhighlight = "Normal:Pmenu,NormalFloat:Pmenu,FloatBorder:Pmenu,Folded:FilebufFoldLine"
      end

      local function close_float()
        if float_valid() then
          pcall(vim.api.nvim_win_close, float_win, true)
        end
        float_win = nil
      end

      local function open_float(dir)
        if float_valid() then
          vim.api.nvim_set_current_win(float_win)
        else
          origin_win = vim.api.nvim_get_current_win()
          local scratch = vim.api.nvim_create_buf(false, true)
          vim.bo[scratch].bufhidden = "wipe"
          float_win = vim.api.nvim_open_win(scratch, true, float_config())
        end
        orig_open(dir)
        apply_float_hl()
      end

      vim.api.nvim_create_autocmd("VimResized", {
        group = float_group,
        callback = function()
          if float_valid() then
            vim.api.nvim_win_set_config(float_win, float_config())
          end
        end,
      })

      vim.api.nvim_create_autocmd("WinClosed", {
        group = float_group,
        callback = function(args)
          if float_win and tonumber(args.match) == float_win then
            float_win = nil
            origin_win = nil
          end
        end,
      })

      filebuf.open_entry = function(buf, entry)
        if not float_valid() then
          return orig_open_entry(buf, entry)
        end
        if entry and entry.type ~= "dir" then
          local target = (vim.uv or vim.loop).fs_realpath(entry.path) or entry.path
          local dir_link = entry.type == "link" and vim.fn.isdirectory(target) == 1
          if not dir_link and vim.fn.filereadable(target) == 1 then
            local dest = origin_win
            close_float()
            if dest and vim.api.nvim_win_is_valid(dest) then
              vim.api.nvim_set_current_win(dest)
            end
            vim.cmd.edit({ args = { vim.fn.fnameescape(target) }, mods = { keepalt = true } })
            return
          end
        end
        orig_open_entry(buf, entry)
      end

      filebuf.close = function(buf)
        orig_close(buf)
        close_float()
      end

      vim.api.nvim_create_user_command("Filebuf", function()
        open_float()
      end, { desc = "Open filebuf in a floating window", force = true })

      vim.keymap.set("n", "<leader>fm", function()
        open_float()
      end, { desc = "File browser" })
    end,
  },

  -- Workspaces / project roots
  {
    "natecraddock/workspaces.nvim",
    dependencies = { "ibhagwan/fzf-lua" },
    opts = {
      hooks = {
        open = { "FzfLua files" },
      },
    },
  },
  {
    "nvim-mini/mini.nvim",
    branch = "stable",
    config = function()
      require("mini.misc").setup()
      MiniMisc.setup_auto_root()
    end,
  },

  {
    "error311/wayfinder.nvim",
    config = function()
      require("wayfinder").setup({
        layout = {
          width = 0.88,
          height = 0.72,
        },
      })
      vim.keymap.set("n", "<leader>wf", "<Plug>(WayfinderOpen)", { desc = "Wayfinder" })
    end,
  },
}
