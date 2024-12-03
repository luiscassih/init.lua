return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  enabled = false,
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = false,
        accept_line = "<C-l>",
        next = "<c-j>",
        prev = "<c-k>",
        dismiss = "<c-x>",
      },
    },
    filetypes = {
      markdown = false,
      help = false,
    },
    panel = {
      enabled = false,
      auto_refresh = true,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>",
      },
    },
  },
}
