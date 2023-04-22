local M = {}

M.close_windows_before_buffers = function()
	if #vim.api.nvim_tabpage_list_wins(0) > 1 then
		return vim.cmd([[:close]])
	end
	return vim.cmd([[:bdelete!]])
end

return M
