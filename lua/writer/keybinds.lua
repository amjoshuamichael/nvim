local bindopts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>t", function()
    vim.cmd[[ Neotree reveal=true position=current action=show ]]
end, bindopts)

vim.keymap.set("n", "<leader>w", function()
    vim.cmd[[ Neotree position=current action=close ]]
end, bindopts)

-- Copy to clipboard
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', bindopts)
vim.api.nvim_set_keymap("n", "<leader>Y", '"+yg_', bindopts)
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', bindopts)
vim.api.nvim_set_keymap("n", "<leader>yy", '"+yy', bindopts)

vim.api.nvim_set_keymap("n","<leader>p", '"+p', bindopts)
vim.api.nvim_set_keymap("n","<leader>P", '"+P', bindopts)
vim.api.nvim_set_keymap("v","<leader>p", '"+p', bindopts)
vim.api.nvim_set_keymap("v","<leader>P", '"+P', bindopts)
