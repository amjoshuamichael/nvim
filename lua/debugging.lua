local dap = require('dap')

dap.defaults.fallback.terminal_win_cmd = '20vsplit new'

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = '/Users/aaroncruz/.vscode/extensions/vadimcn.vscode-lldb-1.9.0/adapter/codelldb',
    args = {"--port", "${port}"},
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.keymap.set("n", "<F7>", dap.toggle_breakpoint, { noremap = true, silent = true })

local unmap = function(key)
    vim.cmd("nunmap " .. key)
end

local exit_debug_mode = function()
    vim.g.debug_mode = false

    unmap("o")
    unmap("i")
    unmap("I")
    unmap("p")
    unmap("go")
    unmap("r")
    unmap("a")
    unmap("A")
    unmap("<ESC>")
end

local enter_debug_mode = function()
    vim.g.debug_mode = true

    local mapopts = { noremap = true, silent = true }
    vim.keymap.set("n", "o", dap.step_over, mapopts)
    vim.keymap.set("n", "i", dap.step_into, mapopts)
    vim.keymap.set("n", "I", dap.step_out, mapopts)
    vim.keymap.set("n", "p", dap.continue, mapopts)
    vim.keymap.set("n", "go", dap.run_to_cursor, mapopts)
    vim.keymap.set("n", "r", function()
        dap.repl.open()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            -- check if window is dap-depl
            print(vim.api.nvim_win_get_config(win).relative)
            if vim.api.nvim_win_get_config(win).relative ~= "" then
                print("Found dap-repl window")
                vim.api.nvim_set_current_win(win)
                break
            end
        end
    end, mapopts)
    vim.keymap.set("n", "a", dap.up, mapopts)
    vim.keymap.set("n", "A", dap.down, mapopts)
    vim.keymap.set("n", "<ESC>", exit_debug_mode, mapopts)
end

vim.api.nvim_create_user_command(
    'CargoDbg',
    function(opts)
        local space_loc = assert(string.find(opts.args, " "))
        local test_mod = string.sub(opts.args, 1, space_loc - 1)
        local test_name = string.sub(opts.args, space_loc + 1, opts.args:len())

        local cmd = "cargo test --target-dir target/debugger --no-run --test " .. test_mod
        local test_build = vim.fn.system(cmd)

        local _, execInfoBeginning = string.find(test_build, "Executable ")

        if execInfoBeginning == nil then
            print("Error: " .. test_build)
            return
        end

        -- looks like tests/_.rs ([Actual file name])            
        local execInfo = string.sub(test_build, execInfoBeginning + 1, test_build:len())
        local _, filePathBeginning = assert(string.find(execInfo, " (", 1, true))
        -- contains the actual file path as a string
        local filePath = string.sub(execInfo, filePathBeginning + 1, execInfo:len() - 2)

        if filePath == nil or filePath == "" then
            print("Error: " .. test_build)
            return
        end

        -- close all windows except the current one
        vim.cmd[[silent only]]
        enter_debug_mode()
        dap.run({
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = vim.fn.getcwd() .. "/" .. filePath,
            stopOnEntry = false,
            args = { test_name },
        }, {})
    end,
    {
        nargs = "*"
    }
)

require("nvim-dap-virtual-text").setup()

vim.keymap.set("n", "<F8>", function() 
    if vim.g.debug_mode then
        exit_debug_mode()
    else
        enter_debug_mode()
    end
end, { noremap = true, silent = true })

