require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        disable = { "c", "rust", "vim" },
    },
    ensure_installed = { "cxc", "lua", "vim", "query", "rust", "c" },
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.cxc = {
    install_info = {
        url = "https://github.com/amjoshuamichael/tree-sitter-cxc",
        files = {"src/parser.c"},
        branch = "main",
    },

    filetype = "cxc",
}

require("vim.treesitter.language").register("cxc", "cxc")

-- ensure that, when we open a .cxc file, we set the syntax & filetype to cxc

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufEnter"}, {
    pattern = {"*.cxc"},
    command = "set filetype=cxc | set syntax=cxc",
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufEnter"}, {
    pattern = {"*.svelte"},
    command = "set syntax=html",
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufEnter"}, {
    pattern = {"*.vert", "*.frag", "*.comp"},
    command = "set filetype=glsl | set syntax=glsl",
})
require("vim.treesitter.language").register("glsl", { "vert", "frag", "comp" })

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufEnter"}, {
    pattern = {"*.whm"},
    command = "set syntax=rust",
})

