return {
  -- "luiscassih/anitheme.nvim",
  dir = "~/dev/AniTheme/",
  enabled = true,
  config = function()
    vim.opt.background = "dark"
    vim.cmd.colorscheme("anitheme")
  end
}
