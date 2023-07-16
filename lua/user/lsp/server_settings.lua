-- ufo need to set setting the lsp server

-- Option 2: nvim lsp as LSP client
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
-- 	dynamicRegistration = false,
-- 	lineFoldingOnly = true,
-- }
-- THESE LINES ARE EVIL NEVER USE THEM (INTRODUCE SLOWNESS)
--[[ local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'} ]]
--[[ for _, ls in ipairs(language_servers) do ]]
--[[     require('lspconfig')[ls].setup({ ]]
--[[         capabilities = capabilities ]]
--[[         -- you can add other fields for setting up lsp server in this table ]]
--[[     }) ]]
--[[ end ]]
-- After setting up mason-lspconfig you may set up servers via lspconfig
--[[ require("lspconfig").clangd.setup({}) ]]
--

local coq = require("coq")
require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        -- require("lspconfig")[server_name].setup({ capabilities = capabilities })
        require("lspconfig")[server_name].setup(coq.lsp_ensure_capabilities({}))
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    --[[ ["rust_analyzer"] = function () ]]
    --[[     require("rust-tools").setup {} ]]
    --[[ end ]]
})
