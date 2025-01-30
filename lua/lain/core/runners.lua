-- Godot
-- vim.cmd.cnoreabbrev("ww :lua OpenGodot()")
vim.api.nvim_command("autocmd FileType gdshader cnoreabbrev <buffer> ww lua OpenGodot()<cr>")
vim.api.nvim_command("autocmd FileType gdscript cnoreabbrev <buffer> ww lua OpenGodot()<cr>")
vim.api.nvim_command("autocmd FileType odin cnoreabbrev <buffer> ww lua OpenRunner('odin')<cr>")

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

function OpenRunner(runner)
  -- Check if Runner buffer already exists
  local runner_buf = vim.fn.bufnr("Runner")
  
  if runner_buf ~= -1 then
    -- Buffer exists, check if it's displayed
    local runner_win = vim.fn.bufwinnr(runner_buf)
    if runner_win ~= -1 then
      -- Window exists, focus it
      vim.cmd(runner_win .. "wincmd w")
      return
    else
      -- Reopen the window with existing buffer
      vim.cmd("botright 15split")
      vim.cmd("buffer Runner")
    end
  else
    -- Create new buffer and window
    vim.cmd("botright 15split")
    vim.cmd("terminal")
    runner_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(runner_buf, "Runner")
  end
  
  -- Configure the buffer
  vim.api.nvim_buf_set_option(runner_buf, "buflisted", false)
  vim.api.nvim_buf_set_option(runner_buf, "bufhidden", "hide")
  
  -- Configure the window
  local winnr = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_option(winnr, "winfixheight", true)
  vim.api.nvim_win_set_option(winnr, "number", false)
  vim.api.nvim_win_set_option(winnr, "relativenumber", false)
  
  -- Set window as locked
  vim.cmd("setlocal nobuflisted")
  vim.cmd("setlocal winfixheight")
  vim.cmd("setlocal nohidden")
  vim.cmd("setlocal noequalalways")
  
  -- Enter terminal mode
  vim.cmd("startinsert")
end
