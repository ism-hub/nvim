-- from https://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim#7321131
vim.cmd [[
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        " let bufFiletype = getbufvar(i, '&filetype')
        " echomsg bufFiletype
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()
]]

function exec_cmd(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return result:gsub("\n$", "")
end

function save_session()
    local cwd                            = vim.fn.getcwd()
    local current_git_branch             = exec_cmd("git branch --show-current")
    local current_git_branch_folder      = current_git_branch:gsub("/", ".")
    local current_git_branch_folder_path = vim.fn.stdpath('state') ..
        "/my_session" .. cwd .. "/" .. current_git_branch_folder

    exec_cmd("mkdir -p " .. current_git_branch_folder_path);
    local session_file = current_git_branch_folder_path .. "/session.vim"
    -- delete all the buffers we can't see before saving the session
    -- vim.cmd(':call DeleteInactiveBufs()')
    vim.cmd(':mksession! ' .. session_file)
    local shada_file = current_git_branch_folder_path .. '/my.shada'
    vim.cmd(":wsh! " .. shada_file)
    print("made session for " .. current_git_branch)
end

function restore_session()
    local cwd                            = vim.fn.getcwd()
    local current_git_branch             = exec_cmd("git branch --show-current")
    local current_git_branch_folder      = current_git_branch:gsub("/", ".")
    local current_git_branch_folder_path = vim.fn.stdpath('state') ..
        "/my_session" .. cwd .. "/" .. current_git_branch_folder

    if vim.fn.isdirectory(current_git_branch_folder_path) == 0 then
        print('nothing to restore')
        return
    end

    local session_file = current_git_branch_folder_path .. "/session.vim"
    local shada_file = current_git_branch_folder_path .. '/my.shada'
    vim.cmd(":source " .. session_file)
    vim.cmd(":rsh! " .. shada_file)
end

vim.api.nvim_create_user_command('Mymksession', save_session, {})
vim.api.nvim_create_user_command('Mysource', restore_session, {})
