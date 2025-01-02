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
require('lazy').setup('code.plugins', {
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

vim.cmd [[ let g:gruvbox_contrast_dark = 'hard' ]]
vim.cmd [[ let g:gruvbox_italic = '0' ]]

--require("rose-pine").setup({
--    variant = "moon",
--    dim_inactive_windows = false,
--    styles = {
--        transparency = false,
--        bold = true,
--        italic = false,
--    },
--})
vim.cmd.colorscheme("gruvbox")

vim.cmd[[
    hi! link @variable GruvboxBlue
    hi! link Delimiter GruvboxOrange
    hi! link @type.builtin.odin GruvboxYellow
]]

--vim.cmd.colorscheme("strawberry-light")

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

require("telescope").setup({
  defaults = {
    preview = {
      filesize_limit = 0.5,
    },
  },
})

require('code.keybinds')
require('code.utilities')
require('code.lsp')
require('code.treesitter')
require('code.debugging')
require('code.statusline')
