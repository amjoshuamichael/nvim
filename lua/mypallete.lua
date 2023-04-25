vim.api.nvim_set_hl(0, 'Cursor', { fg="#D0DBDC", bg="#D0DBDC" })
vim.api.nvim_set_hl(0, 'TermCursor', { fg="none", bg="#D0DBDC" })
vim.api.nvim_set_hl(0, 'TermCursorNC', { fg="none", bg="#D0DBDC" })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg="none", bg="#DCE4E5" })
vim.api.nvim_set_hl(0, 'CursorLine', { fg="NONE", bg="#EEF9FC" })
vim.api.nvim_set_hl(0, 'CursorColumn', { fg="none", bg="#D0DBDC" })
vim.api.nvim_set_hl(0, 'ColorColumn', { fg="none", bg="#D0DBDC" })
vim.api.nvim_set_hl(0, 'LineNr', { fg="#364543", bg="NONE"})
vim.api.nvim_set_hl(0, 'NonText', { fg="#D0DBDC", bg="NONE"})

vim.api.nvim_set_hl(0, 'Normal', { fg='#364543', bg='#F8F6F2'})
vim.api.nvim_set_hl(0, 'Comment', { fg='#A2ABA5', bg='NONE' })

local literalColor = { fg='#FE5D9F', bg='NONE' }
vim.api.nvim_set_hl(0, 'Number', literalColor)
vim.api.nvim_set_hl(0, 'boolean', literalColor)
vim.api.nvim_set_hl(0, 'Float', literalColor)
vim.api.nvim_set_hl(0, 'Character', literalColor)

vim.api.nvim_set_hl(0, 'String', { fg='#19C86A', bg='NONE' })
vim.api.nvim_set_hl(0, 'Operator', { fg='#364543', bg='NONE' })
-- #B148D9

local typeColor = "#FF6C0A"
vim.api.nvim_set_hl(0, 'Type', { fg=typeColor, bg='NONE' })
vim.api.nvim_set_hl(0, 'rustModPath', { fg=typeColor, bg='NONE' })
vim.api.nvim_set_hl(0, 'rustEnumVariant', { fg=typeColor, bg='NONE' })
vim.api.nvim_set_hl(0, 'StorageClass', { fg='#FF8F3C', bg='NONE' })


vim.api.nvim_set_hl(0, 'Define', { fg='#DBBE00', bg='NONE' })
vim.api.nvim_set_hl(0, 'Function', { fg='#0D77E7', bg='NONE' })
vim.api.nvim_set_hl(0, 'Special', { fg='#0D77E7', bg='NONE' })
vim.api.nvim_set_hl(0, 'Identifier', { fg='#3590F3', bg='NONE' })
vim.api.nvim_set_hl(0, 'Label', { fg='#3590F3', bg='NONE' })

local builtIns ='#F71735' 
vim.api.nvim_set_hl(0, 'Keyword', { fg=builtIns, bg='NONE' })
vim.api.nvim_set_hl(0, 'Conditional', { fg=builtIns, bg='NONE' })
vim.api.nvim_set_hl(0, 'Macro', { fg="#0DA3E7", bg='NONE' })
vim.api.nvim_set_hl(0, 'Include', { fg=builtIns, bg='NONE' })
vim.api.nvim_set_hl(0, 'PreProc', { fg=builtIns, bg='NONE' })

vim.api.nvim_set_hl(0, 'Delimiter', { fg='#364543', bg='NONE' })
vim.api.nvim_set_hl(0, 'Visual', { fg='none', bg='#D0DBDC' })
vim.api.nvim_set_hl(0, 'Search', { fg='#364543', bg='#19C86A' })
vim.api.nvim_set_hl(0, 'IncSearch', { fg='#FEFEF7', bg='#0D77E7' })
vim.api.nvim_set_hl(0, 'MatchParen', { fg='#F71735', bg='#D0DBDC' })

vim.api.nvim_set_hl(0, 'Pmenu', { fg='#364543', bg='#DCE4E5' })
vim.api.nvim_set_hl(0, 'PmenuSel', { fg='#FEFEF7', bg='#19C86A' })
vim.api.nvim_set_hl(0, 'PmenuSbar', { fg='none', bg='#DCE4E5' })
vim.api.nvim_set_hl(0, 'PmenuThumb', { fg='none', bg='#364543' })

vim.api.nvim_set_hl(0, 'TabLine', { fg='#C1C4BF', bg='#DCE4E5' })
vim.api.nvim_set_hl(0, 'TabLineSel', { fg='#364543', bg='#EEF9FC' })
vim.api.nvim_set_hl(0, 'TabLineFill', { fg='#C1C4BF', bg='#DCE4E5' })

vim.api.nvim_set_hl(0, 'StatusLine', { fg='#364543', bg='#DCE4E5' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg='#C1C4BF', bg='#DCE4E5' })

vim.api.nvim_set_hl(0, 'VertSplit', { fg='#D0DBDC', bg='NONE' })

vim.api.nvim_set_hl(0, 'Folded', { fg='#C1C4BF', bg='#DCE4E5' })
vim.api.nvim_set_hl(0, 'FoldColumn', { fg='#364543', bg='#DCE4E5' })

vim.api.nvim_set_hl(0, 'SignColumn', { fg='#364543', bg='NONE' })

vim.api.nvim_set_hl(0, 'Error', { fg='#FEFEF7', bg='#F71735' })
vim.api.nvim_set_hl(0, 'Warning', { fg='#FEFEF7', bg='#DBBE00' })
vim.api.nvim_set_hl(0, 'Info', { fg='#FEFEF7', bg='#0D77E7' })
vim.api.nvim_set_hl(0, 'Hint', { fg='#FEFEF7', bg='#19C86A' })

vim.api.nvim_set_hl(0, 'ErrorMsg', { fg='#F71735', bg='#FEFEF7' })
vim.api.nvim_set_hl(0, 'WarningMsg', { fg='#DBBE00', bg='#FEFEF7'})
vim.api.nvim_set_hl(0, 'ModeMsg', { fg='#0D77E7', bg='#FEFEF7' })

vim.cmd([[
    function! SynGroup()
        let l:s = synID(line('.'), col('.'), 1)
        echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
    endfunc
]])

vim.api.nvim_set_keymap("n", "\\hili", ":call SynGroup()<CR>", {silent = true})
