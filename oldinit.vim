:set nonumber

" Plugins
call plug#begin()

" COPILOT
Plug 'github/copilot.vim'

" color scheme
Plug 'morhetz/gruvbox'

Plug 'justinmk/vim-sneak'

Plug 'airblade/vim-rooter'

" telescope file finding
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ahmedkhalf/project.nvim'

Plug 'itchyny/lightline.vim'

" Progress bar
Plug 'j-hui/fidget.nvim'

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

" Diagnostics
Plug 'folke/trouble.nvim'

" Language LSPs
Plug 'simrat39/rust-tools.nvim'

" LSP Setup
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v1.x'}

" markdown
Plug 'gabrielelana/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" NvimTree
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Language-specific plugins
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'plasticboy/vim-markdown'
Plug 'tikhomirov/vim-glsl'
" elm
Plug 'scalameta/nvim-metals'
Plug 'elmcast/elm-vim'

" necessary for this to work: brew install the_silver_searcher
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
call plug#end()

set background=dark

set termguicolors

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" Telescope remaps
nnoremap <leader>ff <cmd>Files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let $FZF_DEFAULT_COMMAND='find . \( -name target -o -name .git \) -prune -o -print'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

lua << EOF 
-- Telescope ignores
require('telescope').setup{ 
    defaults = {
        preview = false,
	    file_ignore_patterns = {
		    "node_modules/.*", ".git/.*", "target",
	    }, 
    }
} 

require'nvim-tree'.setup{}
require'fidget'.setup{
    text = {
        spinner = "dots_pulse",
    },
    window = {
        relative = "editor",
    },
}
EOF 

let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \	  'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename'] ], 
      \   
      \   'right': [ [ 'lineinfo' ] ],
      \
      \ },
      \
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \
      \ }

let g:root = getcwd()

function! LightlineFilename()
  let full_path = expand('%:p')
  let name_to_show = full_path[(len(g:root) + 1):len(full_path)]

  return name_to_show == "" ? "[No File]" : name_to_show 
endfunction

" autocomplete setup

let g:deoplete#enable_at_startup = 1

" Required for operations modifying multiple buffers like rename.
set hidden

" leader + o for newline 
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" convert tabs to spaces
set tabstop=4 shiftwidth=4 expandtab

" Nvim Tree Setup
nnoremap <leader>t :NvimTreeToggle<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Better window movement
nnoremap <leader>wh <C-w>h<C-w>=<C-w>15><C-w>15+
nnoremap <leader>wj <C-w>j<C-w>=<C-w>15><C-w>15+
nnoremap <leader>wk <C-w>k<C-w>=<C-w>15><C-w>15+
nnoremap <leader>wl <C-w>l<C-w>=<C-w>15><C-w>15+
            
nnoremap <leader>ws <C-w>s
nnoremap <leader>wv <C-w>v

" Visual Block via SHIFT-V
nnoremap <S-v> <C-v>

" Remove highlighting when pressing escape in normal mode
nnoremap Esc :noh

" For some transparent effects on windows
set winblend=1
hi FloatBorder guibg=White blend=100    

set relativenumber
set signcolumn=number

lua <<EOF
require'nvim-web-devicons'.setup { }

require("trouble").setup { }

-- Copilot Setup
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

local lsp = require('lsp-zero')
lsp.preset('recommended')

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

local open_float = function()
    local cursor_y, cursor_x = unpack(vim.api.nvim_win_get_cursor(0))

    if cursor_x == 0 then
        vim.diagnostic.open_float({ prefix = "", border = {" ", "", "", " "}})
    else
        vim.diagnostic.open_float({ prefix = "", border = {""}})
    end
end

vim.api.nvim_create_autocmd({"CursorMoved"}, {
    callback = open_float,
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

local on_rust_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'ge', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'ga', function() vim.cmd("TroubleToggle") end, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.code_action, bufopts)
end

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_rust_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

require('nvim-web-devicons').set_icon {
    cxc = {
        icon = "",
        color = "#ffad28",
        cterm_color = "215",
        name = "Cxc"
    }
}

local lspconfig = require 'lspconfig'

local configs = require 'lspconfig.configs'

-- Check if the config is already defined (useful when reloading this file)
if not configs.cxc_lsp then
    configs.cxc_lsp = {
        default_config = {
            cmd = {'/Users/aaroncruz/Desktop/serf/lsp/target/debug/cxc-analyzer'},
            filetypes = {'cxc'},
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end,
        settings = {},
        }
    }
end

lspconfig.cxc_lsp.setup{}

vim.lsp.set_log_level("trace")

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = { "c", "rust", "vim" },
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cxc = {
  install_info = {
    url = "/Users/aaroncruz/desktop/serf/tree-sitter-cxc", -- local path or git repo
    files = {"src/parser.c"},
    -- optional entries:
    branch = "main", -- default branch in case of git repo if different from master
  },

  filetype = "cxc",
}

local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.cxc = "cxc" -- the someft filetype will use the python parser and queries.

EOF

" Underline the offending code
:hi DiagnosticUnderlineError gui=undercurl cterm=undercurl 
:hi DiagnosticUnderlineWarn gui=undercurl cterm=undercurl 

augroup twig_ft
  au!       
  autocmd BufNewFile,BufRead *.lalrpop   set syntax=rust
augroup END

augroup twig_ft
  au!       
  autocmd BufNewFile,BufRead *.cxc   set syntax=cxc
  autocmd BufNewFile,BufRead *.cxc setfiletype cxc
augroup END


" format on save
let g:elm_format_autosave = 1
let g:rustfmt_autosave = 1

function! RustFmt()
    let save_pos = getpos(".")
    silent !rustfmt %
    call setpos(".", save_pos)
endfunction

function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if buflisted(i) && bufname(i) == ''
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        silent exe 'bdelete!' join(empty)
    endif
endfunction

autocmd BufWritePre * call DeleteEmptyBuffers()

autocmd BufWritePost *.rs call RustFmt()
autocmd SwapExists * let v:swapchoice = "e"

set nofoldenable
