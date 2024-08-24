-- based on https://github.com/voldikss/vim-floaterm/issues/208#issuecomment-747829311
-- and https://www.reddit.com/r/vim/comments/780eyl/how_to_configure_vim_to_jump_to_file_line_and/
-- overriding gf to open the file in the last window and not the terminal itself
-- vim.cmd([[
-- function s:open_in_normal_window() abort
--   " get the file string of the form <fname>:<line>:<col>
--   let fileInfoString = expand("<cWORD>")
--   let fileInfo = split(fileInfoString, ":")
--
--   " get <fname>
--   let filePath = findfile(fileInfo[0], join(g:WorkspaceFolders, ','))
--
--   " open it
--   if !empty(filePath)
--     if has_key(nvim_win_get_config(win_getid()), 'anchor') " if the term floating hide it first
--         let g:floaterm_autoinsert = v:false
--         FloatermHide
--         execute 'e ' . filePath
--
--         " goto line num
--         if len(fileInfo) > 1
--           let lineNum = fileInfo[1]
--           execute ':' . lineNum
--         endif
--
--         " goto col
--         if len(fileInfo) > 2
--           let col = fileInfo[2]
--           execute 'normal! '  . col . '|'
--         endif
--
--     endif
--   endif
-- endfunction
--
-- autocmd FileType floaterm nnoremap <silent><buffer> gf :call <SID>open_in_normal_window()<CR>
-- ]])

-- vim.g.floaterm_height = 0.95
-- vim.g.floaterm_width = 0.9

local M = {}

-- Define a function to focus on a window with a filetype that is not in the excluded list
-- from ChatGPT
local function focus_non_excluded_window()
    local excluded_filetypes = { "toggleterm", "neo-tree", "OverseerList" }
    local current_win = vim.api.nvim_get_current_win()

    -- Get all windows
    local windows = vim.api.nvim_list_wins()

    for _, win in ipairs(windows) do
        -- Get the filetype of the current window
        local buf = vim.api.nvim_win_get_buf(win)
        local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

        -- Check if the filetype is not in the excluded list
        local is_excluded = false
        for _, excluded in ipairs(excluded_filetypes) do
            if filetype == excluded then
                is_excluded = true
                break
            end
        end

        if not is_excluded then
            -- Focus on the first non-excluded window
            vim.api.nvim_set_current_win(win)
            return
        end
    end

    -- If all windows are excluded, stay in the current window
    vim.api.nvim_set_current_win(current_win)
end

M.gf = function()
    -- for c# its - path/file.cs(line,col):
    local full_path = vim.fn.expand("<cWORD>")
    local path, line, col = string.match(full_path, "(.*%.cs)%((%d+),(%d+)%)")

    if path == nil then
        return
    end

    -- vim.g.floaterm_autoinsert = false
    vim.cmd("close")
    focus_non_excluded_window()
    vim.cmd('e ' .. path)             -- go to file
    vim.cmd(':' .. line)              -- at line
    vim.cmd('normal! ' .. col .. '|') -- at col
end

return M
