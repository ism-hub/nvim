require("user.options")
require("user.plugins")
require("user.colorscheme")
require("user.keymaps")
require("user.lsp")
require("user.telescope")
require("user.treesitter")
require("user.autopair")
require("user.comment")
require("user.gitsign")
require("user.nvim-tree")
require("user.yank")
-- require("user.lsp-signature")
require("user.lightspeed")
require("user.marks")
require("user.filetype")
-- require("litee.lib").setup({})
-- require("litee.calltree").setup({})
require("user.my_close")
-- require("user.neodev")
require("user.ufo")
require("user.which-key")
require("user.navbuddy")
require("user.session")
require("bigfile").setup({})
require("user.startup")
require("user.tab")
require("user.term")
-- require("user.orgmode")
require("substitute").setup({
    on_substitute = require("yanky.integration").substitute(),
})
require("user.headlines")
require("user.perf")
require("user.toggleterm")
require("user.overseer")

require("dressing").setup()
