return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  enabled = true,
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup({
      filetypes = {
        markdown = false,
        DressingInput = false,
      },
    })
    vim.keymap.set("i", "<c-l>", neocodeium.accept)
    vim.keymap.set("i", "<c-x>", neocodeium.clear)
    vim.keymap.set("i", "<c-j>", neocodeium.cycle_or_complete)
    vim.keymap.set("i", "<c-k>", function() neocodeium.cycle_or_complete(-1) end)
    -- change color for NeoCodeiumLabel 
    vim.api.nvim_set_hl(0, 'NeoCodeiumLabel', { bg = '#7c4dff' })
  end,
}
