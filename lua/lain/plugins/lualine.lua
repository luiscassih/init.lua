return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    lazy = true
  },
  config = function()
    require("lualine").setup({
        sections = {
          lualine_x = {
      --       {
      --         require("noice").api.status.message.get_hl,
      --         cond = require("noice").api.status.message.has,
      --       },
      --       {
      --         require("noice").api.status.command.get,
      --         cond = require("noice").api.status.command.has,
      --         color = { fg = "#ff9e64" },
      --       },
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
            },
      --       {
      --         require("noice").api.status.search.get,
      --         cond = require("noice").api.status.search.has,
      --         color = { fg = "#ff9e64" },
      --       },
          },
        },
    })
  end
}
