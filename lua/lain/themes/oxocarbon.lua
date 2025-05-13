return {
  "nyoom-engineering/oxocarbon.nvim",
  -- "EdenEast/nightfox.nvim",
  config = function()
    vim.opt.background = "dark"
    vim.cmd.colorscheme("oxocarbon")
    -- vim.cmd.colorscheme("carbonfox")
    -- local base = "#080808"
    local base = "none"
    vim.api.nvim_set_hl(0, "Normal", { bg = base })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = base })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = base })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = base })
    vim.api.nvim_set_hl(0, "LineNr", { bg = base })
    vim.api.nvim_set_hl(0, "FoldColumn", { bg = base })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = base })
    -- vim.api.nvim_set_hl(0, "SnacksPicker", { bg = base })
    -- vim.api.nvim_set_hl(0, "SnacksBackdrop", { bg = base })
    vim.api.nvim_set_hl(0, "Visual", { bg = "#00276f"})
    vim.api.nvim_set_hl(0, "NonText", { fg = "#555c77" })
    -- vim.api.nvim_set_hl(0, "VertSplit", { bg = base })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#555c77", bg = base })
    -- vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = base })
  end
}
