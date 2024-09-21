return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")
    local skip_filetypes = { 'markdown' }
    neocodeium.setup({
      filter = function(bufnr)
        if vim.tbl_contains(skip_filetypes, vim.api.nvim_get_option_value("filetype", { buf = bufnr })) then
          return false
        end
        return true
      end
    })
    vim.keymap.set("i", "<c-l>", neocodeium.accept)
    vim.keymap.set("i", "<c-x>", neocodeium.clear)
    vim.keymap.set("i", "<c-j>", neocodeium.cycle_or_complete)
    vim.keymap.set("i", "<c-k>", function() neocodeium.cycle_or_complete(-1) end)
    -- change color for NeoCodeiumLabel 
    vim.api.nvim_set_hl(0, 'NeoCodeiumLabel', { bg = '#7c4dff' })
  end,
}
