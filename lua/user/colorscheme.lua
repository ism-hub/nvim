--[[]]
--[[ local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme) ]]
--[[ if not status_ok then ]]
--[[ 	vim.notify("colorscheme " .. " not found!") ]]
--[[ 	return ]]
--[[ end ]]
--[[]]
-- Lua:
-- For dark theme (neovim's default)

-- kanagawa
vim.cmd("colorscheme kanagawa")
vim.cmd("hi Visual guibg=Grey55")

-- tokyonight
-- vim.g.tokyonight_style = "night"
-- vim.cmd("colorscheme ttokyonight")

-- vscode
-- vim.o.background = "dark"
-- local c = require("vscode.colors").get_colors()
-- require("vscode").setup({})
-- require("vscode").load()
