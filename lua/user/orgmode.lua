-- Load custom treesitter grammar for org filetype
require("orgmode").setup_ts_grammar()

require('orgmode').setup({
    org_agenda_files = vim.g.orgfolder .. '/**/*',
    org_default_notes_file = vim.g.orgfolder .. '/refile.org',
    win_split_mode = 'auto', -- { 'float', 0.9 }, --
    org_hide_emphasis_markers = true,
    org_capture_templates = {
        n = {
            description = 'Note',
            template = '* NOTE %?\n%u\n',
            target = vim.g.orgfolder .. '/notes.org',
        },
        c = {
            description = 'Code snippets/howtos',
            template = '* CODE %?\n#+BEGIN_SRC \n%x\n#+END_SRC\n%u\n',
            target = vim.g.orgfolder .. '/code.org',
        },
        w = {
            description = 'Workspace (code)',
            template = '* CODE %?\n#+BEGIN_SRC \n%x\n#+END_SRC\n%u\n',
            target = vim.g.orgfolder .. '/code_tmp.org',
        }
    },
})

require("org-bullets").setup()
-- require('headlines').setup()
