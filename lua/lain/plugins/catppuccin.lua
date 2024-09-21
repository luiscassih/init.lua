return {
  -- 'nyoom-engineering/oxocarbon.nvim',
  -- 'EdenEast/nightfox.nvim',
  'catppuccin/nvim',
  name = "catppuccin",
  enabled = true,
  config = function()
    -- vim.opt.background = "dark"
    -- vim.cmd.colorscheme("oxocarbon")
    -- vim.cmd.colorscheme("carbonfox")
    -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
    --
    -- catppuccin override
    require("catppuccin").setup({
      styles = {
        -- comments = { "italic" },
        -- conditionals = { "italic" },
      },
      highlight_overrides = {
        all = function(colors)
          return {
            -- Comment = { style = { "italic" } },
            ["@TODOComment"] = { fg = colors.red },
            CurSearch = { bg = colors.sky },
            IncSearch = { bg = colors.sky },
            CursorLineNr = { fg = colors.blue, style = { "bold" } },
            DashboardFooter = { fg = colors.overlay0 },
            TreesitterContextBottom = { style = {} },
            -- WinSeparator = { fg = colors.overlay0, style = { "bold" } },
            WinSeparator = { fg = colors.crust },
            ["@markup.italic"] = { fg = colors.blue, style = { "italic" } },
            ["@markup.strong"] = { fg = colors.blue, style = { "bold" } },
            Headline = { style = { "bold" } },
            Headline1 = { fg = colors.blue, style = { "bold" } },
            Headline2 = { fg = colors.pink, style = { "bold" } },
            Headline3 = { fg = colors.lavender, style = { "bold" } },
            Headline4 = { fg = colors.green, style = { "bold" } },
            Headline5 = { fg = colors.peach, style = { "bold" } },
            Headline6 = { fg = colors.flamingo, style = { "bold" } },
            rainbow1 = { fg = colors.blue, style = { "bold" } },
            rainbow2 = { fg = colors.pink, style = { "bold" } },
            rainbow3 = { fg = colors.lavender, style = { "bold" } },
            rainbow4 = { fg = colors.green, style = { "bold" } },
            rainbow5 = { fg = colors.peach, style = { "bold" } },
            rainbow6 = { fg = colors.flamingo, style = { "bold" } },

            -- custom
            Boolean = { fg = colors.pink, style = { "bold" } },
            TSBoolean = { fg = colors.pink, style = { "bold" } },
            -- Keyword = { fg = colors.pink, style = { "bold" } },
            ["@keyword.return"] = { fg = colors.red, style = { "bold" } },
            ["@parameter"] = { fg = colors.pink, style = { "bold" } },
            ["@tag.builtin"] = { fg = colors.blue, style = { "bold" } },
            ["@type"] = { fg = colors.teal, style = { "bold" } },
            ["@type.builtin"] = { fg = colors.teal, style = { "bold" } },
            ["@tag.attribute.tsx"] = { fg = colors.lavender, style = { } },
          }
        end,
      },
      color_overrides = {
        mocha = {
          -- rosewater = "#F5B8AB",
          -- flamingo = "#F29D9D",
          pink = "#C838C6",
          mauve = "#7C4DFF",
          red = "#f14c4c",
          -- maroon = "#EB788B",
          peach = "#FF6D12",
          yellow = "#FACA64",
          green = "#53A053",
          teal = "#00BEC4",
          blue = "#437AED",
          text = "#CDD6F4",
          subtext1 = "#A3AAC2",
          subtext0 = "#8E94AB",
          overlay2 = "#7D8296",
          overlay1 = "#676B80",
          overlay0 = "#464957",
          surface2 = "#3A3D4A",
          surface1 = "#2F313D",
          surface0 = "#1D1E29",
          base = "#0b0b12",
          mantle = "#11111a",
          crust = "#191926",
        },
      },
      integrations = {
        telescope = {
          enabled = true,
          style = "nvchad",
        },
      },
    })
    vim.cmd.colorscheme("catppuccin-mocha")
  end
}
