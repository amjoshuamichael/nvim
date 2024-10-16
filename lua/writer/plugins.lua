return {
    "NLKNguyen/papercolor-theme",
    "gabenespoli/vim-mutton",
    {
        "rebelot/heirline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        }
    },
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

	'nvim-lua/plenary.nvim',

    -- LSP 
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Instalation & Configuration
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    },

    { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" },
}
