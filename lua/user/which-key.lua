require("which-key").setup({})
local wk = require("which-key")

-- method 4
wk.register({
    ["<leader>f"] = { name = "+search" },
    ["<leader>ff"] = { "Find File" },
    --[[ ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Grep Files" }, ]]
    ["<leader>fb"] = { "Grep In Buffers" },
    ["<leader>fB"] = { "Find Buffer" },
    ["<leader>fh"] = { "Find Help" },
    ["<leader>f/"] = { "Find In Buffer" },
    ["<leader>fm"] = { "Find Mark" },
    ["<leader>fr"] = { "Resume Search" },
    ["<leader>fj"] = { "Find Jump" },
    ["<leader>fp"] = { "Find Search" },
    -- ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    -- ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
})

wk.register({
    ["<leader>d"] = { name = "+debug" },
    ["<leader>dc"] = { "Continue" },
    ["<leader>dn"] = { "Step Over" },
    ["<leader>di"] = { "Step Into" },
    ["<leader>do"] = { "Step Out" },
    ["<leader>db"] = { "Breakpoint" },
    ["<leader>dL"] = { "Breakpoint With Msg" },
    ["<leader>dr"] = { "REPL" },
    ["<leader>dl"] = { "Run Last" },
    ["<leader>dh"] = { "Hover" },
    ["<leader>dp"] = { "Preview" },
    ["<leader>df"] = { "Frames" },
    ["<leader>ds"] = { "Scopes" },
})

wk.register({
    ["g"] = { name = "+lsp" },
    ["gl"] = { "Show Diagnostic" },
    ["gD"] = { "Decleration" },
    ["gi"] = { "Implementation" },
    ["gk"] = { "Signature" },
    ["gr"] = { "References" },
    ["<K>"] = { "Lsp hover" },
})

wk.register({
    ["<leader>w"] = { name = "+lsp-workspace" },
    ["<leader>wa"] = { "Add workspace" },
    ["<leader>wr"] = { "Remove workspace" },
    ["<leader>wl"] = { "List workspaces" },
})

wk.register({
    ["<leader>D"] = { "Lsp type-definition" },
    ["<leader>r"] = { name = "lsp-rename" },
    ["<leader>rn"] = { "Lsp Rename" },
    ["<leader>c"] = { name = "lsp-code-actions" },
    ["<leader>ca"] = { "Lsp Code-Actions" },
    ["<leader>s"] = { "Lsp Format & Save" },
    ["<leader>q"] = { "Diagnostic setloclist" },
    ["<leader>a"] = { "Rust Code-Action-Group" },
    ["<C-space>"] = { "Rust Hover-Actions" },
})

--[[ wk.register({ ]]
--[[ 	["<leader>f"] = { name = "+navigation" }, ]]
--[[ 	["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" }, ]]
--[[ 	["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" }, ]]
--[[ 	["<leader>fn"] = { "<cmd>enew<cr>", "New File" }, ]]
--[[ }) ]]
