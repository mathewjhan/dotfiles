version = '0.20.0'

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path
  .. ";"
  .. xpm_path
  .. "/?.lua;"
  .. xpm_path
  .. "/?/init.lua"

os.execute(
  string.format(
    "[ -e '%s' ] || git clone '%s' '%s'",
    xpm_path,
    xpm_url,
    xpm_path
  )
)

require("xpm").setup({
  plugins = {
    -- Let xpm manage itself
    'dtomvan/xpm.xplr',
    'Junker/nuke.xplr',
    'sayanarijit/type-to-nav.xplr',
    'sayanarijit/fzf.xplr',
    'sayanarijit/trash-cli.xplr',
    'sayanarijit/regex-search.xplr',
  },
  auto_install = true,
  auto_cleanup = true,
})

xplr.config.modes.builtin.default.key_bindings.on_key.x = {
  help = "xpm",
  messages = {
    "PopMode",
    { SwitchModeCustom = "xpm" },
  },
}

-- DEFAULT REGEX
require("regex-search").setup{
  mode = "default",  -- or xplr.config.modes.builtin.default
  key = "/",  -- or xplr.config.modes.builtin.default.key_bindings.on_key["/"]
  prompt = "/",
  initial_input = "(?i)",
}

-- NUKE
require("nuke").setup{
  pager = "more", -- default: less -R
  open = {
    run_executables = true, -- default: false
    custom = {
      {mime_regex = "^text/.*", command = "nvim {}"},
      {mime_regex = "^image/.*", command = "sxiv {} &"},
      {mime_regex = "^video/.*", command = "mpv {} &"},
      {mime_regex = "^audio/.*", command = "vlc {} &"},
      {mime = "application/json", command = "nvim {} &"},
      {mime = "application/pdf", command = "zathura {} &"},
      {mime_regex = ".*", command = "xdg-open {} &"},
    }
  },
  view = {
    show_line_numbers = true, -- default: false
  },
  smart_view = {
    custom = {
      {extension = "so", command = "ldd -r {} | less"},
    }
  }
}

local key = xplr.config.modes.builtin.default.key_bindings.on_key

key.v = {
  help = "nuke",
  messages = {"PopMode", {SwitchModeCustom = "nuke"}}
}
key["f3"] = xplr.config.modes.custom.nuke.key_bindings.on_key.v
key["enter"] = xplr.config.modes.custom.nuke.key_bindings.on_key.o

-- FZF
require("fzf").setup{
  mode = "default",
  key = "ctrl-f",
  args = "--preview 'bat {}'"
}

-- TRASH-CLI
require("trash-cli").setup()

-- USE ZSH AS DEFAULT
xplr.config.modes.builtin.action.key_bindings.on_key["!"].messages = {
  { Call = { command = "zsh", args = { "-i" } } },
  "ExplorePwdAsync",
  "PopMode",
}

-- Layout
-- Based on zentable
local function setup()
  local xplr = xplr

  xplr.fn.custom.zentable_path = function(m)
    local slash = ""
    if m.is_dir then
      slash = "/"
    end

    local sym = ""
    if m.is_symlink then
      sym = " -> "

      if m.is_broken then
        sym = sym .. "×"
      else
        sym = sym .. m.symlink.absolute_path

        if m.symlink.is_dir then
          slash = "/"
          sym = sym .. "/"
        end
      end
    end

    -- local idx = m.relative_index .. " | " .. m.index
    local idx = string.format("%03s %-05s", m.relative_index, m.index) 
    -- local MAX_IDX_SPACE = 10
    -- local padding = string.rep(" ", (MAX_IDX_SPACE - string.len(idx)))

    return idx
      .. m.prefix
      .. m.tree
      .. " "
      .. m.relative_path
      .. slash
      .. sym
      .. m.suffix
  end

  xplr.config.general.table.header.cols = {
    {},
  }

  xplr.config.general.default_ui.prefix = " "
  xplr.config.general.default_ui.suffix = ""

  xplr.config.general.focus_ui.prefix = "> "
  xplr.config.general.focus_ui.suffix = ""

  xplr.config.general.selection_ui.prefix = "▍"
  xplr.config.general.selection_ui.suffix = ""

  xplr.config.general.focus_selection_ui.prefix = "▌ "
  xplr.config.general.focus_selection_ui.suffix = ""

  xplr.config.general.focus_ui.style.bg = { Rgb = { 50, 50, 50 } }

  xplr.config.general.table.row.cols = {
    { format = "custom.zentable_path" },
  }

  xplr.config.general.table.col_widths = {
    { Percentage = 100 },
  }

  xplr.config.general.table.tree = {
    {},
    {},
    {},
  }
end

setup()
