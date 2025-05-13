return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { 'saghen/blink.cmp' },
    -- { 'hrsh7th/cmp-nvim-lsp' },
    -- "folke/neodev.nvim",
  },
  config = function()
    -- require("neodev").setup({})
    local lspconfig = require("lspconfig")
    -- local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local on_attach = function(client, bufnr)
      -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "gs", function() vim.cmd("vsplit"); vim.lsp.buf.definition() end, { desc = "Split Definition", buffer = bufnr, remap = false })
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover", buffer = bufnr, remap = false })
      -- vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, { desc = "Line Diagnostics", buffer = bufnr, remap = false })
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic", buffer = bufnr, remap = false })
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Previous Diagnostic", buffer = bufnr, remap = false })
      vim.keymap.set({ 'v', 'n' }, "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "Code Action", buffer = bufnr, remap = false })
      -- vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.rename() end, { desc = "Rename", buffer = bufnr, remap = false })
      -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      -- vim.keymap.set("n", "<leader>R", ":LspRestart<CR>", opts)
      vim.keymap.set({"n", "v"}, "<leader>lf", vim.lsp.buf.format, { desc = "Format Selected" })
      -- vim.keymap.set({"v"}, "<leader>lf", function() vim.lsp.buf.format({
      --   range = {
      --     ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      --     ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
      --   }
      -- }) end, { desc = "Format Selected" })
    end
    -- local capabilities = cmp_nvim_lsp.default_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Servers
    -- local default_opts = {
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- }

    -- lspconfig.dartls.setup(default_opts)
    -- lspconfig.gdscript.setup(default_opts)
    -- lspconfig.eslint.setup(default_opts)
    lspconfig.csharp_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "csharp-ls" },
      filetypes = { "cs", "razor", "csproj", "fs", "fsproj" },
      root_dir = require("lspconfig").util.root_pattern("*.sln", "*.csproj", "packages.config"),
    }

    lspconfig.ts_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig.rust_analyzer.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ['rust-analyzer'] = {},
      },
    }
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace"
          }
        }
      }
    }
    lspconfig.tailwindcss.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "htmldjango", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    }

    lspconfig.clangd.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      ClangdSwitchSourceHeader = true,
    }

    local with_default = {"ruff_lsp", "golangci_lint_ls", "gopls", "emmet_ls", "ols"}

    for _, lsp in ipairs(with_default) do
      lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end
    vim.lsp.log.set_level(vim.log.levels.ERROR)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'qf',
      callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        vim.keymap.set('n', '<C-n>', '<cmd>cn | wincmd p<CR>', opts)
        vim.keymap.set('n', '<C-p>', '<cmd>cN | wincmd p<CR>', opts)
      end,
    })
  end
}
