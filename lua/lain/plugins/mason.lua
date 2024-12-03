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
        'ts_ls',
        'rust_analyzer',
        'lua_ls',
        'clangd',
        'gopls',
        'golangci_lint_ls',
        'tailwindcss',
        'emmet_ls',
      },
    })
  end
}
