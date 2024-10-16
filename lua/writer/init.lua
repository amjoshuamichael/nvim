vim.cmd[[enew]]
vim.cmd[[
    let g:markdown_fenced_languages = ['html', 'python', 'rust', 'lua', 'vim', 'typescript', 'javascript', 'ruby']
]]

local TAB_WIDTH = 4
vim.opt.tabstop = TAB_WIDTH
vim.opt.softtabstop = TAB_WIDTH
vim.opt.shiftwidth = TAB_WIDTH
vim.opt.expandtab = true

vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

-- set up Lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('writer.plugins', {
    defaults = { lazy = true },
    checker = { enabled = true },
    change_detection = {
        notify = false,
    },
    spec = {
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'matchit',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})

vim.opt.background="light"
vim.cmd.colorscheme("PaperColor")

vim.cmd[[to vnew | vertical resize 38]]

-- this doesn't work if we don't sleep. ah, neovim.
vim.defer_fn(function() vim.cmd([[wincmd w]]) end, 50)

vim.cmd[[bo vnew | vertical resize 38]]

function ResetColors()
    vim.cmd[[
        hi NonText guifg=bg
        hi VertSplit guifg=bg guibg=bg
        hi StatusLineNC guifg=bg guibg=bg
        set fillchars+=vert:\ 
    ]]

    vim.defer_fn(function()
        vim.cmd[[set syntax=markdown]]
        require("writer.statusline")
    end, 50)
end

function ToggleDarkMode()
    if vim.opt.background["_value"] == "light" then
        vim.opt.background = "dark"
    else
        vim.opt.background = "light"
    end

    vim.cmd.colorscheme("PaperColor")
    ResetColors()
end

ToggleDarkMode()

vim.keymap.set("n", "`", ToggleDarkMode, {})

require('neo-tree').setup({
    window = {
        mappings = {
            ["s"] = "",
        }
    }
})

require("nvim-treesitter")
require("writer.keybinds")
