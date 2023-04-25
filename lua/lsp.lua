local lsp = require('lsp-zero').preset("recommended")

lsp.setup()

vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    float = {
        row = -10,
        col = 10,
        border = "none",
        focus = false,
        header = "",
        padding = 2,
    },
})

-- Prevent floating LSP error windows from moving all the way to the left side of the screen 

local open_float = function()
    local _, cursor_x = unpack(vim.api.nvim_win_get_cursor(0))

    if cursor_x == 0 then
        vim.diagnostic.open_float({ prefix = "", border = {" ", "", "", " "}})
    else
        vim.diagnostic.open_float({ prefix = "", border = {""}})
    end
end

vim.api.nvim_create_autocmd({"CursorMoved"}, { callback = open_float })

local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup {
    settings = {
        ['rust-analyzer'] = {},
    },
    init_options = {
        --cargo = {
        --    buildScripts = {
        --        enable = true,
        --    },
        --},
        --procMacro = {
        --    enable = true,
        --}
    }
}
