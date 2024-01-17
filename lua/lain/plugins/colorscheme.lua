return {
  -- 'nyoom-engineering/oxocarbon.nvim',
  'EdenEast/nightfox.nvim',
  config = function()
    -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.opt.background = "dark"
    -- vim.cmd.colorscheme("oxocarbon")
    vim.cmd.colorscheme("carbonfox")
  end
}
