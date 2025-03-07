return {
  "olimorris/codecompanion.nvim",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
    {
      "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
      opts = {},
    },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "ollama",
          keymaps = {
            send = {
              modes = {
                n = { "<CR>" },
                i = nil,
              },
            },
            close = {
              modes = {
                n = "q",
                i = "<c-x>",
              },
            },
            stop = {
              modes = {
                n = "<c-x>",
              },
            }
          }
        },
        inline = {
          adapter = "ollama",
        },
        agent = {
          adapter = "ollama",
        },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "deepseek-coder-v2",
              },
            },
          })
        end,
      },
    })
    vim.api.nvim_set_keymap("n", "<c-l>", "<cmd>CodeCompanionChat<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<c-l>", "<cmd>CodeCompanionChat<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionAdd<cr>", { noremap = true, silent = true })
  end
}
