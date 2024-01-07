-- require("lspconfig")
require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = { "codelldb", "cpptools" } -- for rust
})
require("mason-lspconfig").setup()
require("user.lsp.server_settings")
require("user.lsp.cmp")

require("user.lsp.keymaps")
require("nvim-dap-virtual-text").setup()
require("user.lsp.dapui")
require("lspsaga").setup({
    lightbulb = { virtual_text = false },
    diagnostic = { diagnostic_only_current = true },
})
-- require("user.lsp.coc")
