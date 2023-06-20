-- vim.cmd "colorscheme onedarker"

--[[ local colorscheme = "tokyonight" ]]
--[[ vim.g.tokyonight_style = "night" ]]
--[[]]
--[[ local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme) ]]
--[[ if not status_ok then ]]
--[[ 	vim.notify("colorscheme " .. " not found!") ]]
--[[ 	return ]]
--[[ end ]]
--[[]]
-- Lua:
-- For dark theme (neovim's default)
vim.o.background = "dark"
-- For light theme
--[[ vim.o.background = "light" ]]
local c = require("vscode.colors").get_colors()
require("vscode").setup({})
require("vscode").load()
