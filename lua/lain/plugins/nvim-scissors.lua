return {
	"chrisgrieser/nvim-scissors",
	dependencies = "nvim-telescope/telescope.nvim", -- optional
	opts = {
		snippetDir = "/home/l/.config/nvim/snippets",
	},
  config = function()
    local scissors = require("scissors")
    vim.keymap.set("n", "<leader>ke", function() scissors.editSnippet() end)
    vim.keymap.set({ "n", "x" }, "<leader>ka", function() scissors.addNewSnippet() end)
  end
}
