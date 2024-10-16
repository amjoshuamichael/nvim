vim.cmd[[
    set showcmd
    set laststatus=2
    set cmdheight=1
]]

vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function()
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes('<Cmd>call v:lua.call()<CR>', true, false, true),
            'n',
            true
        )
    end
})

_G.call = function() end

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = {
    cursor = utils.get_highlight("StatusLine").bg,
    boring = utils.get_highlight("StatusLineNC").fg,
    plaintext = utils.get_highlight("Normal").fg,
    statuslinebg = "#282C40",
    bright_fg = utils.get_highlight("Folded").fg,
    red = utils.get_highlight("DiagnosticError").fg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("NonText").fg,
    orange = utils.get_highlight("Constant").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
}

local align = { provider = "%=" }
local space = { provider = " " }

local mode_icon = {
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    static = {
        mode_names = {
            n = "N",
            no = "N",
            nov = "N",
            noV = "N",
            ["no\22"] = "N",
            niI = "N",
            niR = "N",
            niV = "N",
            nt = "N",
            v = "v",
            vs = "v",
            V = "v",
            Vs = "v",
            ["\22"] = "V",
            ["\22s"] = "V",
            s = "s",
            S = "S",
            ["\19"] = "S",
            i = "I",
            ic = "I",
            ix = "I",
            R = "R",
            Rc = "R",
            Rx = "R",
            Rv = "R",
            Rvc = "R",
            Rvx = "R",
            c = ":",
            cv = ":",
            r = ".",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
        },
        mode_colors = {
            n = "red" ,
            i = "green",
            v = "cyan",
            V =  "cyan",
            ["\22"] =  "cyan",
            c =  "orange",
            s =  "purple",
            S =  "purple",
            ["\19"] =  "purple",
            R =  "orange",
            r =  "orange",
            ["!"] =  "red",
            t =  "red",
        }
    },
    provider = function(self)
        local mode = self.mode:sub(1, 1)
        return self.mode_names[self.mode]
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_colors[mode], bg="statuslinebg", bold = true, reverse=false}
    end,
    update = {
        "ModeChanged",
        pattern = "*:*",
    },
}

vim.cmd[[set noshowmode]]

local file_name_block = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

local file_icon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local file_name = {
    provider = function(self)
        -- :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[noname]" end
        -- if the filename would occupy more than 1/4th of the available space, we trim the file
        -- path to its initials
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = "plaintext", },
}

local file_name_color_modifier = {
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = "plaintext", bold = true, force=true }
        end
    end,
}

local file_name_save_indicator = {
    provider = function(self)
        if vim.bo.readonly then
            return "."
        elseif vim.bo.modified then
            return "*"
        else
            return " "
        end
    end,
    hl = { fg = "plaintext", },
}

file_name_block = utils.insert(
    file_name_block,
    file_icon,
    space,
    utils.insert(file_name_color_modifier, file_name, file_name_save_indicator)
)

local ruler = {
    provider = "(%1.9l, %1.3c)",
    hl = { fg = "plaintext", },
}

local scrollbar = {
    static = {
        sbar = { '█', '▇', '▆', '▅', '▄', '▃', '▂', '▁' }
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
    end,
    hl = { fg = "plaintext", },
}

local pos_info_block = { scrollbar, space, ruler, }

local copilot_active = {
    condition = function()
        for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            if server.name == "copilot" then return true end
        end
        return false
    end,
    provider = function()
        return "󰚩"
    end,
    hl = { fg = "green", bold = true },
}

local lsp_active = {
    condition = conditions.lsp_attached,
    update = {'LspAttach', 'LspDetach'},

    provider  = function()
        local names = {}
        for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            if server.name ~= "copilot" then
                -- get first three chars of the server name
                local concatname = string.sub(server.name, 1, 4)
                table.insert(names, concatname)
            end
        end

        if #names == 0 then
            return ""
        else
            return "[" .. table.concat(names, ", ") .. "]"
        end
    end,
    hl = { fg = "green", bold = true },
}

local diagnostics = {
    condition = function()
        if vim.bo.readonly then return false end

        for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            if server.name ~= "copilot" then return true end
        end

        return false
    end,

    static = {
        -- strip whitespcae off of string
        error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text:match("%S+"),
        warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarning")[1].text:match("%S+"),
        info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text:match("%S+"),
        hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text:match("%S+"),
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

        self.nodiagnostics = self.errors == 0 and self.warnings == 0 and self.hints == 0 and self.info == 0
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    hl = function(self)
        if self.nodiagnostics then
            return { fg = "plaintext", bold=false, force=true }
        else
            return { fg = "plaintext", }
        end
    end,

    {
        provider = function(self)
            if self.errors == 0 then return self.error_icon else return self.errors end
        end,
        hl = { fg = "diag_error" },
    },
    space,
    {
        provider = function(self)
            if self.warnings == 0 then return self.warn_icon else return self.warnings end
        end,
        hl = { fg = "diag_warn" },
    },
    space,
    {
        provider = function(self)
            if self.hints == 0 then return self.hint_icon else return self.hints end
        end,
        hl = { fg = "diag_info" },
    },
    space,
    {
        provider = function(self)
            if self.info == 0 then return self.info_icon else return self.info end
        end,
        hl = { fg = "diag_hint" },
    },
}

local dap_messages = {
    provider = function()
        if session == nil then
            return "No debug session."
        else
            return require("dap").status()
        end
    end,
    hl = "Debug"
    -- see Click-it! section for clickable actions
}

local default_status_line = {
    condition = function() return conditions.is_active() and not vim.g.debug_mode end ,

    space, mode_icon, space, file_name_block, space, pos_info_block, align, copilot_active, space, lsp_active, space, diagnostics, space
}

local debugging_status_line = {
    condition = function() return conditions.is_active() and vim.g.debug_mode end ,

    space, { provider = "DEBUG", hl = { fg = "purple", bold = true } }, space, dap_messages, align
}

local inactive_status_line = {
    condition = conditions.is_not_active,

    space, file_name_block, align, space, lsp_active, space, diagnostics, space
}

local StatusLines = {
    hl = function()
        return { bg = "statuslinebg", reverse=false, }
    end,

    -- the first statusline with no condition, or which condition returns true is used.
    -- think of it as a switch case with breaks to stop fallthrough.
    fallthrough = false,

    default_status_line, inactive_status_line, debugging_status_line
}

require("heirline").setup({
    statusline = StatusLines,
    opts = { colors = colors }
})
