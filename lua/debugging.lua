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

vim.api.nvim_create_user_command(
    'CargoDbg',
    function(opts)
        local space_loc = assert(string.find(opts.args, " "))
        local test_mod = string.sub(opts.args, 1, space_loc - 1)
        local test_name = string.sub(opts.args, space_loc + 1, opts.args:len())

        local cmd = "cargo test --target-dir target/debugger --no-run --test " .. test_mod
        local test_build = vim.fn.system(cmd)

        local _, execInfoBeginning = assert(string.find(test_build, "Executable "))
        -- looks like tests/_.rs ([Actual file name])            
        local execInfo = string.sub(test_build, execInfoBeginning + 1, test_build:len())
        local _, filePathBeginning = assert(string.find(execInfo, " (", 1, true))
        -- contains the actual file path as a string
        local filePath = string.sub(execInfo, filePathBeginning + 1, execInfo:len() - 2)

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

local libmodal = require("libmodal")

local unmap = function(key)
    vim.cmd("nunmap " .. key)
end

local exit_debug_mode = function()
    unmap("o")
    unmap("i")
    unmap("<ESC>")
end

local enter_debug_mode = function()
    local mapopts = { noremap = true, silent = true }
    vim.keymap.set("n", "o", dap.step_over, mapopts)
    vim.keymap.set("n", "i", dap.step_into, mapopts)
    vim.keymap.set("n", "<ESC>", exit_debug_mode, mapopts)
end

vim.keymap.set("n", "<F8>", enter_debug_mode, { noremap = true, silent = true })

