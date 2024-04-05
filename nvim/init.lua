vim.cmd [[ source ~/.config/home-dot-files/.vimrc ]]

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

            'folke/neodev.nvim',
        },
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',

            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline'
        },
    },

    { 'nvim-tree/nvim-tree.lua',       dependencies = { "nvim-tree/nvim-web-devicons" } },

    {
        -- side git changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '' },
                change = { text = '||' },
                delete = { text = '' },
                topdelete = { text = '‾' },
                changedelete = { text = '|' },
            },
        },
    },

    -- Themes
    'navarasu/onedark.nvim',
    'lunarvim/synthwave84.nvim',
    'tanvirtin/monokai.nvim',

    {
        --  statusline
        'nvim-lualine/lualine.nvim',
        opts = {
            sections     = {
                lualine_a = {},
                lualine_b = { 'filename' },
                lualine_c = {},
                lualine_x = {},
                lualine_y = { 'branch', 'diff', 'diagnostics' },
                lualine_z = {}
            },
            options      = {
                icons_enabled = true,
                component_separators = '|',
                section_separators = '',
                path = 1,
                symbols = {
                    modified = '',
                },
            },
            dependencies = {
                'nvim-tree/nvim-web-devicons'
            },
        },
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        opts = {
            char = "",
            show_current_context = true,
            show_current_context_start = true,
        }
    },

    { 'numToStr/Comment.nvim',         opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context'
        },
        build = ':TSUpdate',
    },

    'vimwiki/vimwiki',

    {
        "ellisonleao/carbon-now.nvim",
        lazy = true,
        cmd = "CarbonNow",
        opts = {}
    },

    { 'NvChad/nvim-colorizer.lua', opts = {} },

    'mhartington/formatter.nvim'

}, {})

require 'volcano.tree-sitter'
require 'volcano.lsp'
require 'volcano.nvim-tree'
require 'volcano.vimwiki'
require 'volcano.theme'
require 'volcano.cmp'
require 'volcano.telescope'
require 'volcano.autocmd'
require 'volcano.vimwiki'
require 'volcano.last_nth_bfr'

-- TODO
-- local util = require "formatter.util"
--
-- require("formatter").setup {
--   logging = true,
--   log_level = vim.log.levels.WARN,
--   filetype = {
--     -- Formatter configurations for filetype "lua" go here
--     -- and will be executed in order
--     lua = {
--       -- "formatter.filetypes.lua" defines default configurations for the
--       -- "lua" filetype
--       require("formatter.filetypes.lua").stylua,
--
--       -- You can also define your own configuration
--       function()
--         -- Supports conditional formatting
--         if util.get_current_buffer_file_name() == "special.lua" then
--           return nil
--         end
--
--         -- Full specification of configurations is down below and in Vim help
--         -- files
--         return {
--           exe = "stylua",
--           args = {
--             "--search-parent-directories",
--             "--stdin-filepath",
--             util.escape_path(util.get_current_buffer_file_path()),
--             "--",
--             "-",
--           },
--           stdin = true,
--         }
--       end
--     },
--
--     ["*"] = {
--       require("formatter.filetypes.any").remove_trailing_whitespace
--     }
--   }
-- }

vim.cmd [[ source ~/.config/nvim/nvimrc ]]
