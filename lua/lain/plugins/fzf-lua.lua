return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons", { "junegunn/fzf", build = "./install --bin" } },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({})
    vim.keymap.set("n", "<C-f>", ":FzfLua live_grep<CR>", { noremap = true })
    vim.keymap.set("n", "<C-p>", ":FzfLua files<CR>", { noremap = true })
    vim.keymap.set("n", "<C-b>", ":FzfLua buffers<CR>", { noremap = true })
    -- notes
    -- alt-a to toggle select all
    -- alt-q to send toggled to qf
    -- tab or shift tab to toggle the current and next/prev
  end
}
