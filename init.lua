vim.opt.termguicolors = true

if string.match(table.concat(vim.v.argv), "writer") then
    require("writer")
else
    require("code")
end
