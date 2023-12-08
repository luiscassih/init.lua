return {
  "szw/vim-maximizer",
  lazy = false,
  keys = {
    { "<C-w>m", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
  },
  config = function ()
   vim.g.maximizer_set_default_mapping = 0
  end
}
