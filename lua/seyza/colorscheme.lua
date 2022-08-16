local colorscheme = "tokyonight"

vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_loops = false
vim.g.tokyonight_italic_conditionals = false

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
     vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
