return {
  "nyoom-engineering/oxocarbon.nvim",
  -- "EdenEast/nightfox.nvim",
  enabled = false,
  config = function()
    vim.opt.background = "dark"
    vim.cmd.colorscheme("oxocarbon")
    -- vim.cmd.colorscheme("carbonfox")
    local base = "#080808"
    vim.api.nvim_set_hl(0, "Normal", { bg = base })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = base })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = base })
    vim.api.nvim_set_hl(0, "LineNr", { bg = base })
    vim.api.nvim_set_hl(0, "FoldColumn", { bg = base })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = base })
  end
}
