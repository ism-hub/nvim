-- Utility to change guifont size
function _G.adjust_font_size(delta)
    local font = vim.opt.guifont:get()[1]
    local name, size = string.match(font, "^(.*):h(%d+)$")
    size = tonumber(size) + delta
    vim.opt.guifont = string.format("%s:h%d", name, size)
end
