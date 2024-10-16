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
    update_in_insert = true,
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
        ['rust-analyzer'] = {
            diagnostics = {
                disabled = { "inactive-code", "unresolved-proc-macro" },
            },
        },
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

require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}

-- from https://github.com/folke/trouble.nvim/issues/52
local signs = { Error = " ", Warning = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
