return {
  'eandrju/cellular-automaton.nvim',
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>ca", "<cmd>CellularAutomaton make_it_rain<CR>")
  end
}
