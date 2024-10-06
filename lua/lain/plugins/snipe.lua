return {
  "leath-dub/snipe.nvim",
  keys = {
    {"<c-k>", function () require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu"}
  },
  opts = {
    ui = {
      position = "cursor",
      -- position = "bottomleft",
    },
    hints = {
      dictionary = "1234567890",
    },
    navigate = {
      cancel_snipe = "<c-c>",
    }
  }
}
