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
    'tpope/vim-fugitive',

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
                lualine_b = {
                    {
                        'filename',
                        symbols = {
                            modified = '', -- Text to show when the file is modified.
                            readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
                            unnamed = '[No Name]', -- Text to show for unnamed buffers.
                            newfile = '[New]', -- Text to show for newly created file before first write
                        }
                    }

                },
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
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x',                                dependencies = { 'nvim-lua/plenary.nvim' } },
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

    -- 'vimwiki/vimwiki',
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit

        lazy = true,
        ft = "markdown",

        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        --   -- refer to `:h file-pattern` for more examples
        --   "BufReadPre path/to/my-vault/*.md",
        --   "BufNewFile path/to/my-vault/*.md",
        -- },
        dependencies = {

            -- Required.
            "nvim-lua/plenary.nvim",


            -- see below for full list of optional dependencies 👇
        },
        opts = {
            workspaces = {
                {
                    name = "notes",
                    path = "~/notes",
                },
            },

            -- see below for full list of options 👇
        }
    },

    {
        "ellisonleao/carbon-now.nvim",
        lazy = true,
        cmd = "CarbonNow",
        opts = {}
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },

    { 'NvChad/nvim-colorizer.lua', opts = {} },

    { -- Autoformat
        'stevearc/conform.nvim',
        lazy = false,
        keys = {
            {
                '<leader>F',
                function()
                    require('conform').format { async = true, lsp_fallback = true }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            notify_on_error = true,
            formatters_by_ft = {
                lua = { 'stylua' },
                -- Conform can also run multiple formatters sequentially
                -- python = { "isort", "black" },
                --
                -- You can use a sub-list to tell conform to run *until* a formatter
                -- is found.
                javascript = { { "prettierd", "prettier" } },
                typescriptreact = { { "prettierd", "prettier" } },
                json = { { "prettierd", "prettier" } },
            },
        },
    },

    { -- Linting

        'mfussenegger/nvim-lint',

        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require 'lint'
            lint.linters_by_ft = {
                -- markdown = { 'markdownlint' },
                json = { "jsonlint" },
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" }
            }
            local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    require('lint').try_lint()
                end,

            })
        end,

    },

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

vim.cmd [[ source ~/.config/nvim/nvimrc ]]
