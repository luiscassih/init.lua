return {
  "2giosangmitom/nightfall.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
  }, -- Add custom configuration here
  config = function(_, opts)
    require("nightfall").setup(opts)
    vim.cmd("colorscheme nightfall") -- Choose from: nightfall, deeper-night, maron, nord
  end,
}
