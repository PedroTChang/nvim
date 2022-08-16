local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local lualine_scheme = "dracula"

local status_theme_ok, theme = pcall(require, "lualine.themes." .. lualine_scheme)
if not status_theme_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local icons = require "seyza.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warning .. " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    return "-- " .. str .. " --"
  end,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local location = {
  "location",
  padding = 0,
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

-- lualine.setup {
--   options = {
--     globalstatus = true,
--     icons_enabled = true,
--     theme = "dracula",
--     component_separators = { left = "", right = "" },
--     section_separators = { left = "", right = "" },
--     -- disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
--     disabled_filetypes = { "alpha", "dashboard", "toggleterm" },
--     always_divide_middle = true,
--   },
--   sections = {
--     -- lualine_a = { branch, diagnostics },
--     lualine_a = { branch },
--     lualine_b = { diagnostics },
--     lualine_c = {},
--     -- lualine_c = {
--     --   { nvim_gps, cond = hide_in_width },
--     -- },
--     -- lualine_x = { "encoding", "fileformat", "filetype" },
--     lualine_x = { diff, spaces, "encoding", filetype },
--     lualine_y = { location },
--     lualine_z = { progress },
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {},
--     lualine_x = { "location" },
--     lualine_y = {},
--     lualine_z = {},
--   },
--   tabline = {},
--   extensions = {},
-- }
--
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {progress},
    lualine_z = {location}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
