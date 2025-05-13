return {
  -- "luiscassih/anitheme.nvim",
  dir = "~/dev/AniTheme/",
  -- enabled = false,
  config = function()
    vim.opt.background = "dark"
    -- vim.g.anitheme_colorscheme = "ariake"
    vim.cmd.colorscheme("anitheme")
  end
}
