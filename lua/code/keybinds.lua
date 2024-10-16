local bindopts = { silent = true }

vim.api.nvim_set_keymap("n", "sh", ":FocusSplitLeft<CR>", bindopts)
vim.api.nvim_set_keymap("n", "sj", ":FocusSplitDown<CR>", bindopts)
vim.api.nvim_set_keymap("n", "sk", ":FocusSplitUp<CR>", bindopts)
vim.api.nvim_set_keymap("n", "sl", ":FocusSplitRight<CR>", bindopts)
vim.api.nvim_set_keymap("n", "ss", ":FocusSplitNicely<CR>", bindopts)

vim.keymap.set("n", "<Leader>t", ":Neotree toggle=true<CR>", bindopts)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
vim.keymap.set("n", "<leader>G", builtin.grep_string, {})

local warnopts = { severity = vim.diagnostic.severity.WARN }
local erroropts = { severity = vim.diagnostic.severity.ERROR }
vim.keymap.set("n", "[w", function() vim.diagnostic.goto_prev(warnopts) end, bindopts)
vim.keymap.set("n", "]w", function() vim.diagnostic.goto_next(warnopts) end, bindopts)
vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev(erroropts) end, bindopts)
vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next(erroropts) end, bindopts)

-- Copy to clipboard
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', bindopts)
vim.api.nvim_set_keymap("n", "<leader>Y", '"+yg_', bindopts)
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', bindopts)
vim.api.nvim_set_keymap("n", "<leader>yy", '"+yy', bindopts)

vim.api.nvim_set_keymap("n","<leader>p", '"+p', bindopts)
vim.api.nvim_set_keymap("n","<leader>P", '"+P', bindopts)
vim.api.nvim_set_keymap("v","<leader>p", '"+p', bindopts)
vim.api.nvim_set_keymap("v","<leader>P", '"+P', bindopts)

-- Visual Block via SHIFT-V
vim.api.nvim_set_keymap("n","<S-v>", "<C-v>", bindopts)

-- LSP options
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bindopts)
vim.keymap.set('n', 'ge', vim.lsp.buf.rename, bindopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bindopts)
vim.keymap.set('n', 'gh', vim.lsp.buf.code_action, bindopts)

--vim.keymap.set('i', '<C-j>', require("copilot.suggestion").accept_line)
