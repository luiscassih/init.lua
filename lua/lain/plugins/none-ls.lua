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
    -- local function split_parameters()
    --   local bufnr = vim.api.nvim_get_current_buf()
    --   local row = vim.api.nvim_win_get_cursor(0)[1]
    --   local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]
    --
    --   -- Find the opening and closing parentheses
    --   local start_paren = line:find("%(")
    --   local end_paren = line:find("%)", start_paren)
    --
    --   if not start_paren or not end_paren then
    --     return
    --   end
    --
    --   -- Extract parameters
    --   local params = line:sub(start_paren + 1, end_paren - 1)
    --   local split_params = vim.split(params, ",")
    --
    --   -- Trim whitespace and add comma to each parameter
    --   for i, param in ipairs(split_params) do
    --     split_params[i] = vim.trim(param) .. ","
    --   end
    --
    --   -- Remove trailing comma from the last parameter
    --   split_params[#split_params] = split_params[#split_params]:gsub(",$", "")
    --   print(vim.inspect(unpack(split_params)))
    --
    --   -- Prepare the new lines
    --   local new_lines = {
    --     line:sub(1, start_paren)
    --   }
    --
    --   for _, param in ipairs(split_params) do
    --     table.insert(new_lines, param)
    --   end
    --
    --   table.insert(new_lines, line:sub(end_paren))
    --
    --   -- Replace the original line with the new lines
    --   vim.api.nvim_buf_set_lines(bufnr, row - 1, row, false, new_lines)
    --
    --   -- Indent the parameter lines
    --   for i = 2, #new_lines - 1 do
    --     vim.api.nvim_buf_set_lines(bufnr, row - 1 + i - 1, row - 1 + i, false, {"    " .. new_lines[i]})
    --   end
    --
    --   -- Format the changed lines
    --   vim.lsp.buf.format({
    --     range = {
    --       start = { row, 0 },
    --       ["end"] = { row + #new_lines - 1, 0 }
    --     }
    --   })
    -- end


    local function split_parameters()
      local bufnr = vim.api.nvim_get_current_buf()
      local row = vim.api.nvim_win_get_cursor(0)[1]
      local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]

      -- Find ()
      local start_paren, end_paren = line:find("%((.-)%)")
      if not start_paren or not end_paren then return end

      -- Extract parameters
      local params = vim.split(line:sub(start_paren + 1, end_paren - 1), ",")

      -- Prepare the new lines
      local new_lines = { line:sub(1, start_paren) }

      -- Trim and add a comma to each parameter unless it's the last one
      for i, param in ipairs(params) do
        table.insert(new_lines, vim.trim(param) .. (i < #params and "," or ""))
      end

      table.insert(new_lines, line:sub(end_paren))

      -- Replace the original line with the new lines
      vim.api.nvim_buf_set_lines(bufnr, row - 1, row, false, new_lines)

      -- Format the changed lines
      vim.lsp.buf.format({
        range = {
          start = { row, 0 },
          ["end"] = { row + #new_lines - 1, 0 }
        }
      })
    end

    null_ls.register({
      name = "split-parameters",
      method = null_ls.methods.CODE_ACTION,
      filetypes = { "_all" },
      generator = {
        fn = function()
          return {
            {
              title = "Split parameters",
              action = split_parameters
            }
          }
        end
      }
    })
  end
}
