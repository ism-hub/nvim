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

vim.diagnostic.config({
    severity_sort = true,
    -- underline = {
    --   severity = { max = vim.diagnostic.severity.INFO }
    -- },
    virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR }
    },
})

-- inlay hints (only version > .10)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            f = function()
                vim.lsp.inlay_hint.enable(args.buf, true)
            end
            if not pcall(f) then
                print("vim.lsp.inlay_hint.enable FAILED maybe version < .10 ?")
            end
            -- vim.lsp.inlay_hint.enable(args.buf, true)
        end
        -- whatever other lsp config you want
    end
})

-- vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float()]])


local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        -- require("lspconfig")[server_name].setup({ capabilities = capabilities })
        require("lspconfig")[server_name].setup { capabilities = capabilities }
    end,
    -- rust analyzer doesn't use lspconfig
    ["rust_analyzer"] = function()
        vim.g.rustaceanvim = function()
            local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/"
            local codelldb_path = extension_path .. "bin/codelldb"
            local liblldb_path = extension_path .. "packages/codelldb/extension/lldb/lib/liblldb.so"

            local cfg = require('rustaceanvim.config')
            return {
                server = {
                    on_attach = function(client, bufnr)
                        -- you can also put keymaps in here
                        vim.keymap.set("n", "<C-space>", "<cmd>:RustLsp hover actions<CR>", { buffer = bufnr })
                    end,
                },
                dap = {
                    adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
                },
            }
        end
    end
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function()
    --     local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/"
    --     local codelldb_path = extension_path .. "bin/codelldb"
    --     local liblldb_path = extension_path .. "packages/codelldb/extension/lldb/lib/liblldb.so"
    --
    --     local rt = require("rust-tools")
    --
    --     rt.setup({
    --         dap = {
    --             adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    --         },
    --         server = {
    --             on_attach = function(_, bufnr)
    --                 -- Hover actions
    --                 vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    --                 -- Code action groups
    --                 --[[ vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr }) ]]
    --             end,
    --         },
    --     })
    -- end
})
