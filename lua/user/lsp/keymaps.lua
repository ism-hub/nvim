--[[ When a server attaches himself to a buffer make lsp api available ]]
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local wk = require("which-key")
-- wk.register({
--     ["g"] = { name = "+lsp" },
--     ["gl"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostic" },
--     ["gb"] = { "<cmd>Lspsaga show_buf_diagnostics<CR>", "Show Buf Diagnostic" },
--     ["gw"] = { "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Show Workspace Diagnostic" },
--     ["[e"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev Diagnostic" },
--     ["]e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
--     ["[E"] = {
--         function()
--             require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
--         end,
--         "Prev Diagnostic",
--     },
--     ["]E"] = {
--         function()
--             require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
--         end,
--         "Next Diagnostic",
--     },
--     ["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
--     ["[d"] = { vim.diagnostic.goto_prev, "Next Diagnostic" },
-- })



local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = { noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", { expr = true })

-- Use `[e` and `]e` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[e", "<Plug>(coc-diagnostic-prev)", {})
keyset("n", "]e", "<Plug>(coc-diagnostic-next)", {})
keyset("n", "[e", "<Plug>(coc-diagnostic-prev)", {})
keyset("n", "]e", "<Plug>(coc-diagnostic-next)", {})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {})
keyset("n", "gy", "<Plug>(coc-type-definition)", {})
keyset("n", "gi", "<Plug>(coc-implementation)", {})
keyset("n", "gr", "<Plug>(coc-references)", {})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {})

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {})

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = { nowait = true }
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", {})
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", {})
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", {})

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = { nowait = true, expr = true }
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

-- Add `:Format` command to format current buffer
-- vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
-- keyset("n", "<leader>s", "<cmd>Format<CR>:w<CR>", opts)

-- Formatting selected code
vim.keymap.set("x", "<leader>s", "<Plug>(coc-format-selected)", { noremap = true })

-- Format and save
keyset("n", "<leader>s", "<cmd>call CocAction('format')<CR>:w<CR>", {})


-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- wk.register({
--     ["<leader>w"] = { name = "+lsp-workspace" },
--     ["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, "Add workspace" },
--     ["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, "Remove workspace" },
--     ["<leader>wl"] = {
--         function()
--             print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--         end,
--         "List workspaces",
--     },
-- }, opts)

-- debugging (dap)
wk.register({
    ["<leader>d"] = { name = "+debug" },
    ["<leader>dc"] = {
        function()
            require("dap").continue()
        end,
        "Continue",
    },
    ["<leader>dn"] = {
        function()
            require("dap").step_over()
        end,
        "Step Over",
    },
    ["<leader>di"] = {
        function()
            require("dap").step_into()
        end,
        "Step Into",
    },
    ["<leader>do"] = {
        function()
            require("dap").step_out()
        end,
        "Step Out",
    },
    ["<leader>db"] = {
        function()
            require("dap").toggle_breakpoint()
        end,
        "Breakpoint",
    },
    ["<leader>dL"] = {
        function()
            require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        "Breakpoint With Msg",
    },
    ["<leader>dr"] = {
        function()
            require("dap").repl.open()
        end,
        "REPL",
    },
    ["<leader>dl"] = {
        function()
            require("dap").run_last()
        end,
        "Run Last",
    },
    ["<leader>dh"] = {
        function()
            require("dap.ui.widgets").hover()
        end,
        "Hover",
    },
    ["<leader>dp"] = {
        function()
            require("dap.ui.widgets").preview()
        end,
        "Preview",
    },
    ["<leader>df"] = {
        function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end,
        "Frames",
    },
    ["<leader>ds"] = {
        function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
        end,
        "Scopes",
    },
}, opts)
