return {
    -- dev utilities
	'svermeulen/vimpeccable',

    -- colorschemes
    "https://github.com/morhetz/gruvbox",
    { "rose-pine/neovim", name = "rose-pine" },
    { "nightsense/strawberry" },
    "svermeulen/text-to-colorscheme.nvim",

    -- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
        branch = 'v2.x',
		dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
            },
        },
    },

    -- Window management
	'nvim-focus/focus.nvim',

    -- File finding
	'nvim-lua/plenary.nvim',
	'BurntSushi/ripgrep',
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	'nvim-telescope/telescope.nvim',

    -- LSP 
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Instalation & Configuration
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            ---- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},

            ---- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    },

    {
        'j-hui/fidget.nvim', -- loading
        branch = "legacy",
    },

    -- language specific
    'rust-lang/rust.vim',

    { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" },

    -- miscellaneous
    'norcalli/nvim-colorizer.lua',
    'cocopon/pgmnt.vim',

    {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = {
            'mfussenegger/nvim-dap',
        }
    },

    'rebelot/heirline.nvim',
}
