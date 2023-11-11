local flash = require("flash")
vim.keymap.set({ "n", "x", "o" }, "s", function () flash.jump() end)
vim.keymap.set({ "n", "x", "o" }, "S", function () flash.treesitter() end)
