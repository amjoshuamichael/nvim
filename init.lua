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

-- plugins
require('lazy').setup('plugins', {
    defaults = { lazy = true },
    checker = { enabled = true },
    change_detection = {
        notify = false,
    },
    spec = {
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        { import = "lazyvim.plugins.extras.coding.copilot" },
        { import = "plugins" },
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

vim.opt.termguicolors = true

vim.cmd [[ let g:gruvbox_contrast_dark = 'hard' ]]

-- depending on my mood

vim.cmd.colorscheme("kanagawa")
--vim.cmd.colorscheme("gruvbox")

-- Disable of netrw recommended for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('focus').setup()
require('colorizer').setup()

require('neo-tree').setup({
    window = {
        mappings = {
            ["s"] = "",
        }
    }
})

require('fidget').setup({
    text = {
        spinner = "dots_pulse",
    },
    window = {
        relative = "editor",
    },
})

require('keybinds')
require('utilities')
require('lsp')
require('treesitter')
require('debugging')
require('statusline')
--require('mypallete')
require('copilot').setup({
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
    },
})
