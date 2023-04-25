-- tab width
local TAB_WIDTH = 4
vim.opt.tabstop = TAB_WIDTH
vim.opt.softtabstop = TAB_WIDTH
vim.opt.shiftwidth = TAB_WIDTH
vim.opt.expandtab = true

-- numbers in the gutter
vim.opt.relativenumber = true
vim.opt.signcolumn = 'number'

-- For some transparent effects on windows
vim.opt.winblend = 1
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#ffffff', blend = 100 })

-- TODO: delete empty buffers
