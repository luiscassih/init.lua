-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = false,
                color_overrides = {
                    mocha = {
                        -- originals from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/mocha.lua
                        rosewater = "#F5E0DC",
                        flamingo = "#F2CDCD",
                        pink = "#F5C2E7",
                        mauve = "#CBA6F7",
                        red = "#F38BA8",
                        maroon = "#EBA0AC",
                        peach = "#FAB387",
                        yellow = "#F9E2AF",
                        green = "#A6E3A1",
                        teal = "#94E2D5",
                        sky = "#89DCEB",
                        sapphire = "#74C7EC",
                        blue = "#89B4FA",
                        lavender = "#B4BEFE",
                        text = "#CDD6F4",
                        subtext1 = "#BAC2DE",
                        subtext0 = "#A6ADC8",
                        overlay2 = "#9399B2",
                        overlay1 = "#7F849C",
                        overlay0 = "#6C7086",
                        surface2 = "#585B70",
                        surface1 = "#45475A",
                        surface0 = "#313244",
                        base = "#1E1E2E",
                        mantle = "#181825",
                        crust = "#11111B",
                        -- custom
                        -- base = "#11111B",
                        base = "#05050A",
                        -- base = "#000000",
                        mantle = "#181825",
                        crust = "#11111B",
                        -- text = "#dbdae9",
                        -- green = "#4dc067",
                        -- lavender = "#5B85FF",
                        -- lavender = "#FFFFFF",
                    },
                },
                integrations = {
                    harpoon = true,
                    telescope = true,
                    gitsigns = true,
                }
            })
            vim.cmd('colorscheme catppuccin')
        end
    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    use('ThePrimeagen/harpoon')
    use('mbbill/undotree')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }

    use('tpope/vim-commentary')

    use 'nvim-tree/nvim-web-devicons'

    -- use({
    --     'ptzz/lf.vim',
    --     requires = { { 'voldikss/vim-floaterm' } }
    -- })

    use('stevearc/dressing.nvim')
    use {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        config = function()
            require("flutter-tools").setup {}
        end
    }

    use({
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function()
            require("fidget").setup {}
        end
    })

    use('vimwiki/vimwiki')
    use {
      'stevearc/oil.nvim',
      config = function() require('oil').setup() end
    }
    use {
      "nvim-telescope/telescope-file-browser.nvim",
      requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = function ()
        vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
        require("neo-tree").setup({
          window = {
            width = 30,
          },
          filesystem = {
            follow_current_file = true
          }
        })
      end
    }
end)
