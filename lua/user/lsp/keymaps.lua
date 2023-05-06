--[[ When a server attaches himself to a buffer make lsp api available ]]
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local wk = require("which-key")
wk.register({
	["g"] = { name = "+lsp" },
	["gl"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostic" },
	["gb"] = { "<cmd>Lspsaga show_buf_diagnostics<CR>", "Show Buf Diagnostic" },
	["gw"] = { "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Show Workspace Diagnostic" },
	["[e"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev Diagnostic" },
	["]e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
	["[E"] = {
		function()
			require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end,
		"Prev Diagnostic",
	},
	["]E"] = {
		function()
			require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
		end,
		"Next Diagnostic",
	},
	["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
	["[d"] = { vim.diagnostic.goto_prev, "Next Diagnostic" },
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, noremap = true }
		wk.register({
			["gD"] = { vim.lsp.buf.declaration, "Deceleration" },
			["gd"] = { vim.lsp.buf.definition, "Deceleration" },
			["gi"] = { vim.lsp.buf.implementation, "Implementation" },
			["gk"] = { vim.lsp.buf.signature_help, "Signature" },
			["gr"] = { require("telescope.builtin").lsp_references, "References" },
			["<K>"] = { "<cmd>Lspsaga hover_doc<CR>", "Lsp hover" },
		}, opts)

		wk.register({
			["<leader>w"] = { name = "+lsp-workspace" },
			["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, "Add workspace" },
			["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, "Remove workspace" },
			["<leader>wl"] = {
				function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end,
				"List workspaces",
			},
		}, opts)

		vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async = false})' ]])
		wk.register({
			["<leader>D"] = { vim.lsp.buf.type_definition, "Lsp type-definition" },
			["<leader>r"] = { name = "lsp-rename" },
			["<leader>rn"] = { vim.lsp.buf.rename, "Lsp Rename" },
			["<leader>s"] = { "<cmd>:Format<CR>:w<CR>", "Lsp Format & Save" },
			["<leader>q"] = { vim.diagnostic.setloclist, "Set loclist" },
			["<leader>a"] = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
			["<C-space>"] = { "Rust Hover-Actions" },
		}, opts)
		--[[ vim.api.nvim_set_keymap("n", "<leader>s", ":Format<CR>:w<CR>", { noremap = true }) ]]
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client.server_capabilities.documentHighlightProvider then
			vim.cmd([[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]])
			vim.cmd([[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]])
			vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
		end

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
	end,
})
