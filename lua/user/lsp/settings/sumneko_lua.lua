local sumneko_binary_path = vim.fn.exepath('lua-language-server')
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h:h')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
	settings = {

		Lua = {
			runtime = {
            		    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
			    version = 'LuaJIT',
			    -- Setup your lua path
			    path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				--library = {
				--	[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				--	[vim.fn.stdpath("config") .. "/lua"] = true,
				--},
			},
		},
	},
}
