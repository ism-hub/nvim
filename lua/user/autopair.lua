-- Setup nvim-cmp.
-- npairs = require("nvim-autopairs")

-- npairs.setup {
--    check_ts = true,
--    ts_config = {
--        lua = { "string", "source" },
--        javascript = { "string", "template_string" },
--        java = false,
--    },
--    disable_filetype = { "TelescopePrompt", "spectre_panel" },
--    fast_wrap = {
--        map = "<M-e>",
--        chars = { "{", "[", "(", '"', "'" },
--        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
--        offset = 0, -- Offset from pattern match
--        end_key = "$",
--        keys = "qwertyuiopzxcvbnmasdfghjkl",
--        check_comma = true,
--        highlight = "PmenuSel",
--        highlight_grey = "LineNr",
--    },
--}

-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- cmp = require("cmp")
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })


local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = true, map_cr = true, fast_wrap = {}, disable_filetype = { "TelescopePrompt" , "vim" },})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
-- added this line in options.lua
-- vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
-- remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
-- remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
-- remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
-- remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
-- _G.MUtils = {}
--
-- MUtils.CR = function()
--     if vim.fn.pumvisible() ~= 0 then
--         if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
--             return npairs.esc('<c-y>')
--         else
--             return npairs.esc('<c-e>') .. npairs.autopairs_cr()
--         end
--     else
--         return npairs.autopairs_cr()
--     end
-- end
-- remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })
--
-- MUtils.BS = function()
--     if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
--         return npairs.esc('<c-e>') .. npairs.autopairs_bs()
--     else
--         return npairs.autopairs_bs()
--     end
-- end
-- remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
