-- require("lspconfig")
-- require("mason").setup()
-- require("mason-lspconfig").setup()
-- require("user.lsp.server_settings")

require("user.lsp.keymaps")
-- require("user.lsp.rust")
require("nvim-dap-virtual-text").setup()
require("user.lsp.dapui")
-- require("lspsaga").setup({})
require("user.lsp.coc")
