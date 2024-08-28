-- Godot
-- vim.cmd.cnoreabbrev("ww :lua OpenGodot()")
vim.api.nvim_command("autocmd FileType gdshader cnoreabbrev <buffer> ww lua OpenGodot()<cr>")
vim.api.nvim_command("autocmd FileType gdscript cnoreabbrev <buffer> ww lua OpenGodot()<cr>")

function Runners()
  vim.ui.select({
    "godot",
    "godot2",
    "godot3",
  }, {
    prompt = "Select runner",
  }, function (runner)
     print(runner)
  end)
end
