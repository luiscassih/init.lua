return {
  "nvimtools/none-ls.nvim",
  dependencies = {
      "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    -- local none_ls = require("none-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.gdlint,
        require("none-ls.diagnostics.eslint_d").with({
        -- none_ls.diagnostics.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
          end
        }),
        null_ls.builtins.formatting.gdformat,
        require("none-ls.formatting.jq"),
      }
    })
  end
}
