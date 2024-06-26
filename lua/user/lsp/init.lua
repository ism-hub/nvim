-- require("lspconfig")
require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = { "codelldb", "coreclr", "cpptools" }, -- coreclr is netcoredbg
    handlers = {},                                            -- :DapContinue will ask for the .exe and start the debugger
})
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "clangd", "rust_analyzer", "omnisharp" },
}
require('mason-tool-installer').setup {
    ensure_installed = { "cspell" }
}
require("user.lsp.server_settings")
require("user.lsp.cmp")

require("user.lsp.keymaps")
require("nvim-dap-virtual-text").setup()
require("user.lsp.dapui")
require("user.lsp.servers_dap_configs")
require("lspsaga").setup({
    lightbulb = { virtual_text = false },
    diagnostic = { diagnostic_only_current = true },
})
require("user.lsp.null-ls")
-- require("user.lsp.coc")
