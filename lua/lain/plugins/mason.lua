return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    -- "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    mason.setup({})
    -- require("mason-nvim-dap").setup({
    --   ensure_installed = { "javascript" }
    -- })
    mason_lspconfig.setup({
      ensure_installed = {
        'tsserver',
        'rust_analyzer',
        'lua_ls',
      },
    })
  end
}
