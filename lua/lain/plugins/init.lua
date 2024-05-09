return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
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
      -- vim.cmd('colorscheme catppuccin')
    end
  },

  -- 'tpope/vim-commentary',
  'nvim-tree/nvim-web-devicons',
  'stevearc/dressing.nvim',

  {
    'j-hui/fidget.nvim',
    -- tag = 'legacy',
    config = function()
      require("fidget").setup {}
    end
  },

  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup({
        default_file_explorer = true,
        use_default_keymaps = false,
        keymaps = {
          ['gd'] = "actions.select",
          ['g?'] = "actions.show.help",
          ['go'] = "actions.parent",
          ['gg'] = "actions.open_cwd",
          ['cd'] = "actions.tcd",
          ['gh'] = "actions.toggle_hidden",
          ['gs'] = "actions.select_vsplit",
          ['gS'] = "actions.select_split",
        },
      })
    end
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require("neo-tree").setup({
        window = {
          width = 30,
        },
        filesystem = {
          follow_current_file = true,
          hijack_netrw_behavior = "disabled",
        }
      })
    end
  },

  -- 'SirVer/ultisnips',
}
