local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.deps'

if not vim.loop.fs_stat(mini_path) then
    vim.fn.system({
      'git', 'clone', '--filter=blob:none', '--branch', 'stable',
      'https://github.com/echasnovski/mini.deps', mini_path
    })
    vim.cmd[[packadd mini.deps | helptags ALL]]
end

require('mini.deps').setup({ path = { package = path_package } })

vim.g.mapleader = '\\'

local add = MiniDeps.add

-- colorscheme(s) & icons

-- gruvbox
add("https://github.com/ellisonleao/gruvbox.nvim")
require("gruvbox").setup({ 
    italic = { strings = false },
    contrast = "hard"
})
vim.cmd[[colorscheme gruvbox]]

-- witchhazel
add("https://github.com/theacodes/witchhazel")

-- cyberdream
add("https://github.com/scottmckendry/cyberdream.nvim")
require("cyberdream").setup({ 
    theme = { variant = "light" },
})

-- catppuccin
add("https://github.com/catppuccin/nvim")
require("catppuccin").setup({
    flavour = "mocha",
    no_italic = true,
})

add('echasnovski/mini.icons')
require('mini.icons').setup()

-- file explorer
add({ source = "https://github.com/echasnovski/mini.files" })
require('mini.files').setup({
  mappings = {
    close       = '<ESC>',
    go_in       = '}',
    go_out      = '{',
    go_in_plus  = ']',
    go_out_plus = '[',
    synchronize = '=',
    trim_left   = '<',
    trim_right  = '>',
  },
  options = {
    permanent_delete = false,
    use_as_default_explorer = false,
  },
})
vim.keymap.set("n", "<leader>t", MiniFiles.open, {})

-- ripgrep
add({ source = "https://github.com/BurntSushi/ripgrep" })

-- file picker
add({ source = "https://github.com/echasnovski/mini.pick" })
require('mini.pick').setup()
vim.keymap.set("n", "<leader>f", "<cmd>Pick files tool='git'<cr>")

-- copy / paste to system clipboard
vim.keymap.set("v", "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>Y", '"+yg_', {})
vim.keymap.set("n", "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>yy", '"+yy', {})
vim.keymap.set("n","<leader>p", '"+p', {})
vim.keymap.set("n","<leader>P", '"+P', {})
vim.keymap.set("v","<leader>p", '"+p', {})
vim.keymap.set("v","<leader>P", '"+P', {})

-- Visual Block via SHIFT-V
vim.keymap.set("n","<S-v>", "<C-v>", {})

-- tab stuff
local TAB_WIDTH = 4
vim.opt.tabstop = TAB_WIDTH
vim.opt.softtabstop = TAB_WIDTH
vim.opt.shiftwidth = TAB_WIDTH
vim.opt.expandtab = true

-- numbers in the gutter
vim.opt.relativenumber = true
vim.opt.signcolumn = 'number'

-- color column
vim.opt.colorcolumn = "81"

-- treesitter
add("https://github.com/nvim-treesitter/nvim-treesitter")
require("nvim-treesitter").setup()
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
})
require("vim.treesitter.language").register("glsl", { "vert", "frag", "comp" })

-- focus
add("https://github.com/nvim-focus/focus.nvim")
require("focus").setup({
    autoresize = {
        height_quickfix = 10,
    }
})
vim.keymap.set("n", "sh", "<cmd>FocusSplitLeft<CR>")
vim.keymap.set("n", "sj", "<cmd>FocusSplitDown<CR>")
vim.keymap.set("n", "sk", "<cmd>FocusSplitUp<CR>")
vim.keymap.set("n", "sl", "<cmd>FocusSplitRight<CR>")
vim.keymap.set("n", "ss", "<cmd>FocusSplitNicely<CR>")

-- find odin symbols
add("https://github.com/nvim-lua/plenary.nvim")
add("https://github.com/nvim-telescope/telescope.nvim")
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local telescope_finders = require('telescope.finders')
local telescope_pickers = require('telescope.pickers')
local telescope_previewers = require('telescope.previewers')
local telescope_config = require('telescope.config').values
local telescope_actions = require('telescope.actions') 

local function find_odin_symbols()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local symbols = {}

    local symbol_regex = "([A-Za-z0-9_]+) *::"

    for i, line in ipairs(lines) do
        local start_idx, end_idx = line:find(symbol_regex)
        if start_idx then
            table.insert(symbols, {
                -- subtract 2 to ignore the ::
                name = line:sub(1, end_idx - 2),
                lnum = i,
            })
        end
    end

    table.sort(symbols, function(a, b) return a.lnum < b.lnum end)

    telescope_pickers.new({}, {
        prompt_title = "Symbols",
        finder = telescope_finders.new_table({
            results = symbols,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = string.format("%4d | %s", entry.lnum, entry.name),
                    ordinal = entry.name,
                    lnum = entry.lnum
                }
            end
        }),
        previewer = telescope_previewers.new_buffer_previewer({
            define_preview = function(self, entry, _)
                local preview_lines = {}
                local start_line = entry.value.lnum
                table.insert(preview_lines, lines[start_line])
                start_line = start_line + 1
                
                for i = start_line, #lines do
                    local line_text = lines[i]

                    -- Stop if we find a blank line or hit the next symbol
                    if line_text:match(symbol_regex) then
                        break
                    end

                    table.insert(preview_lines, line_text)
                end
                
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, preview_lines)
                vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'odin')
            end
        }),
        sorter = telescope_config.generic_sorter({}),
        layout_config = {
            preview_width = 80,
        },
        sorting_strategy = 'ascending',
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                telescope_actions.close(prompt_bufnr)
                vim.api.nvim_win_set_cursor(0, {selection.lnum, 0})
            end)
            return true
        end
    }):find()
end

local function odin_goto_definition()
    local word = vim.fn.expand('<cword>')
    local regex = string.format("'(^|\\W+)%s *::'", word)
    local cmd = string.format("rg -n %s .", regex)
    print(cmd)
    
    local output = vim.fn.systemlist(cmd)
    
    if #output ~= 0 then
        local match = output[1]:match('(.-):%d+:')
        local line = output[1]:match(':(%d+):')
        
        pcall(function()
            vim.cmd(string.format('e %s', match))
        end)
        vim.api.nvim_win_set_cursor(0, {tonumber(line), 0})
    else
        print('cannot find symbol ' .. regex)
    end
end

function odin_check()
  -- Save current file
  vim.cmd('write')
  -- Run odin check and populate quickfix
  vim.cmd[[set errorformat=%f(%l:%c)\ %m]]
  vim.cmd('cexpr system("odin check . -debug -thread-count:1")')
  -- Open quickfix window
  vim.cmd('copen')
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'odin',
    callback = function()
        vim.keymap.set('n', 'gd', odin_goto_definition, {buffer = true})
        vim.api.nvim_create_user_command('OdinSymbols', find_odin_symbols, {})
        vim.keymap.set("n", "<leader>s", "<cmd>OdinSymbols<CR>")
        vim.keymap.set('n', '<leader>c', odin_check)
    end
})

-- grep
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>")

-- Close quickfix menu after selecting choice
vim.api.nvim_create_autocmd(
  "FileType", 
  {
    pattern={"qf"},
    command=[[nnoremap <buffer> <CR> <CR>:cclose<CR>zz]]
  }
)

add('mrcjkb/rustaceanvim')
vim.g.rustaceanvim = {
    tools = {
        cargo_override = "RUSTFLAGS='-Awarnings' cargo"
    }
}

vim.keymap.set('n', '<leader>e', function() vim.cmd.RustLsp { 'testables', bang = true }  end)
vim.keymap.set('n', '<leader>E', function() vim.cmd.RustLsp { 'testables' } end)

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
        },
    },
    update_in_insert = true,
    underline = true,
})

local warnopts = { severity = vim.diagnostic.severity.WARN }
vim.keymap.set("n", "[w", function() vim.diagnostic.goto_prev(warnopts) end, bindopts)
vim.keymap.set("n", "]w", function() vim.diagnostic.goto_next(warnopts) end, bindopts)
local erroropts = { severity = vim.diagnostic.severity.ERROR }
vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev(erroropts) end, bindopts)
vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next(erroropts) end, bindopts)

-- Prevent floating LSP error windows from moving all the way to the left side of the screen 

local open_float = function()
    local mode = vim.fn.mode();
    if mode == 'v' or mode == 'V' or mode == '\x16' then
        return
    end

    local _, cursor_x = unpack(vim.api.nvim_win_get_cursor(0))

    if cursor_x == 0 then
        vim.diagnostic.open_float({ prefix = "", border = {" ", "", "", " "}})
    else
        vim.diagnostic.open_float({ prefix = "", border = {""}})
    end
end

vim.api.nvim_create_autocmd({"CursorMoved"}, { callback = open_float })
