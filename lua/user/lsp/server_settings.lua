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
        -- if client.server_capabilities.inlayHintProvider then -- for some reason omnisharp inlayHintProvider is prob false
        f = function()
            vim.lsp.inlay_hint.enable(true)
        end
        if not pcall(f) then
            print("vim.lsp.inlay_hint.enable FAILED maybe version < .10 ?")
        end
        -- vim.lsp.inlay_hint.enable(args.buf, true)
        -- end
        -- whatever other lsp config you want
    end
})

-- vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float()]])


local capabilities = require('cmp_nvim_lsp').default_capabilities()
local util = require 'lspconfig/util'
require("mason-lspconfig").setup({
    handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
            -- require("lspconfig")[server_name].setup({ capabilities = capabilities })
            require("lspconfig")[server_name].setup { capabilities = capabilities }
        end,
        -- this is the "suboptimal" way, but intgrates better with nvim
        ["omnisharp"] = function()
            require("lspconfig")["omnisharp"].setup({
                capabilities = capabilities,
                flags = { debounce_text_changes = 800, },
                handlers = {
                    ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
                    ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
                    ["textDocument/references"] = require('omnisharp_extended').references_handler,
                    ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
                },
                root_dir = util.root_pattern("*.sln", "**/*.sln"),
                settings = {
                    FormattingOptions = {
                        -- Enables support for reading code style, naming convention and analyzer
                        -- settings from .editorconfig.
                        EnableEditorConfigSupport = true,
                        -- Specifies whether 'using' directives should be grouped and sorted during
                        -- document formatting.
                        OrganizeImports = false,
                    },
                    MsBuild = {
                        -- If true, MSBuild project system will only load projects for files that
                        -- were opened in the editor. This setting is useful for big C# codebases
                        -- and allows for faster initialization of code navigation features only
                        -- for projects that are relevant to code that is being edited. With this
                        -- setting enabled OmniSharp may load fewer projects and may thus display
                        -- incomplete reference lists for symbols.
                        LoadProjectsOnDemand = false,
                    },
                    RoslynExtensionsOptions = {
                        -- Enables support for roslyn analyzers, code fixes and rulesets.
                        EnableAnalyzersSupport = false,
                        -- Enables support for showing unimported types and unimported extension
                        -- methods in completion lists. When committed, the appropriate using
                        -- directive will be added at the top of the current file. This option can
                        -- have a negative impact on initial completion responsiveness,
                        -- particularly for the first few completion sessions after opening a
                        -- solution.
                        EnableImportCompletion = false,
                        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                        -- true
                        AnalyzeOpenDocumentsOnly = false,
                        EnableDecompilationSupport = true,
                    },
                },
                Sdk = {
                    -- Specifies whether to include preview versions of the .NET SDK when
                    -- determining which version to use for project loading.
                    IncludePrereleases = true,
                },
            })
        end,
        ["gopls"] = function()
            require("lspconfig")["gopls"].setup({
                capabilities = capabilities,
                settings = {
                    gopls = {
                        ["ui.inlayhint.hints"] = {
                            assignVariableTypes = true,
                            compositeLiteralTypes = true,
                            compositeLiteralFields = true,
                            functionTypeParameters = true,
                            rangeVariableTypes = true,
                            constantValues = true,
                            parameterNames = true
                        },
                    },
                },
            })
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
    }
})
