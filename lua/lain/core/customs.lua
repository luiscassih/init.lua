function Cmd(...)
    local command = table.concat({...}, ' ')
    vim.cmd('split')
    vim.cmd('wincmd J')
    vim.cmd('resize 8')
    vim.cmd('term')
    vim.cmd('startinsert')
    if command ~= '' then
        vim.api.nvim_feedkeys(command .. '\n','n', true)
        vim.schedule(function()
            vim.cmd('stopinsert')
            vim.cmd('wincmd p')
        end)
    end
end

function CloseTerm()
    vim.cmd('wincmd j')
    vim.cmd('startinsert')
    vim.api.nvim_feedkeys('exit\n','n', true)
    vim.schedule(function()
        vim.cmd('bd!')
    end)
end

function SplitTri()
  vim.cmd('vsplit')
  vim.cmd('vertical resize +20')
  vim.cmd('wincmd l')
  vim.cmd('split')
  vim.cmd('resize +8')
  vim.cmd('wincmd j')
  CheckTermBuffer()
end

function SendFidgetNotification(msg, ttl)
  local fidget = require('fidget')
  fidget.notify(msg, vim.log.levels.INFO, { ttl = ttl or 5})
end

function GetTermBuffer()
  for _, buf in ipairs(vim.fn.getbufinfo()) do
    if vim.fn.bufname(buf.bufnr):match("term://") then
      return buf.bufnr
    end
  end
end

function SendKeysToTerm(commands)
  local buf = GetTermBuffer()
  if buf ~= nil then
    -- vim.api.nvim_buf_call(buf, function()
    --   vim.api.nvim_feedkeys(commands, 'i', true)
    -- end)
    -- vim.api.nvim_buf_attach(buf, false, {
    --   on_lines = function(_, _, _, _, _, _)
    --     vim.api.nvim_feedkeys(commands, 'i', true)
    --   end
    -- })
    local winid = vim.fn.bufwinid(buf)
    if winid ~= -1 then
      vim.api.nvim_set_current_win(winid)
      local cmds = vim.api.nvim_replace_termcodes('i' .. commands .. '<CR><C-\\><C-n>', false, true, true)
      vim.api.nvim_feedkeys(cmds, 'i', true)
    end
  end
end

-- Detect filetype, example: Dart
-- read file dart.txt from termcommands/ folder in config
-- list every line in FZF
-- SendKeysToTerm(selected)

function InputToTerm()
  -- get type of file
end

function CheckTermBuffer()
  for _, buf in ipairs(vim.fn.getbufinfo()) do
    if vim.fn.bufname(buf.bufnr):match("term://") then
      local winid = vim.fn.bufwinid(buf.bufnr)
      if winid ~= -1 then
        vim.api.nvim_set_current_win(winid)
      else
        -- If the terminal buffer is not currently open in any window,
        -- you can handle it here (e.g., open a new split).
        -- vim.cmd('split | buffer ' .. buf.bufnr)
        vim.api.nvim_set_current_buf(buf.bufnr)
      end
      return
    end
  end
end


-- TODO
-- function to search :h for the selected text

-- based on a mixture from
-- https://stackoverflow.com/a/77181885
-- https://stackoverflow.com/a/74675717
function RemoveQFItem(mode)
  local qf_list = vim.fn.getqflist()

  -- Distinguish mode for getting delete index and delete count
  local del_qf_idx
  local del_ct
  if mode == 'v' then
    del_qf_idx = vim.fn.getpos("'<")[2] - 1
    del_ct = vim.fn.getpos("'>")[2] - del_qf_idx
  else
    del_qf_idx = vim.fn.line('.') - 1
    del_ct = vim.v.count > 1 and vim.v.count or 1
  end

  -- Delete lines and update quickfix
  for _ = 1, del_ct do
    table.remove(qf_list, del_qf_idx + 1)
  end

  vim.fn.setqflist(qf_list, 'r')

  if #qf_list > 0 then
    -- vim.cmd(tostring(del_qf_idx + 1) .. 'cfirst')
    vim.cmd('copen')
  else
    vim.cmd('cclose')
  end

  -- If not at the end of the list, stay at the same index, otherwise, go one up.
  local new_idx = del_qf_idx < #qf_list and del_qf_idx+1 or math.max(del_qf_idx, 1)
  local winid = vim.fn.win_getid() -- Get the window ID of the quickfix window
  vim.api.nvim_win_set_cursor(winid, {new_idx, 0})
end


function CreateFloatWindow(opts)
  local relative = opts.relative or 'editor'
  local columns, lines = vim.o.columns, vim.o.lines
  if relative == 'win' then
    columns, lines = vim.api.nvim_win_get_width(0), vim.api.nvim_win_get_height(0)
  end

  local win_opts = {
    width = opts.width or math.min(columns - 4, math.max(80, columns - 20)),
    height = opts.height or math.min(lines - 4, math.max(80, lines - 10)),
    style = 'minimal',
    relative = relative,
    border = opts.border
  }

  win_opts.row = opts.row or math.floor(((lines - win_opts.height) / 2 ) - 1)
  win_opts.col = opts.col or math.floor((columns - win_opts.width) / 2)

  if opts.title then
    win_opts.title = opts.title
    win_opts.title_pos = opts.title_pos or 'center'
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  local winid = vim.api.nvim_open_win(bufnr, true, win_opts)

  if opts.window_on_create then
    opts.window_on_create()
  end

  return bufnr, winid
end

function TestFloatWindow()
  local win = vim.api.nvim_get_current_win()
  local bufnr, winid = CreateFloatWindow({})
  -- open new float window
  vim.api.nvim_win_set_buf(winid, bufnr)

  -- set map for only this float window
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<esc>', '<cmd>close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-c>', '<cmd>close<CR>', { noremap = true, silent = true })

end

-- TODO an alternative window of harpoon list (C-e) but using fzf?

function TestFZF()
  local fzf = require('fzf')
  coroutine.wrap(function()
    local result = fzf.fzf({"uno", "dos", "tres"}, "--ansi")
    if result then
      SendFidgetNotification(result[1])
      result = fzf.fzf({"cuatro", "cinco", "seis"}, "--ansi")
      vim.cmd('startinsert')
      if result then
        SendFidgetNotification(result[1])
      end
    end
  end)()
end

function WaitForCoroutine(routine, callback)
  coroutine.resume(routine)
  if coroutine.status(routine) == 'dead' then
    callback()
  else
    vim.defer_fn(function()
      WaitForCoroutine(routine, callback)
    end, 10)
  end
end

function TestFZF2()
  local fzf = require('fzf')
  local routine = coroutine.create(function ()
    local result = fzf.fzf({"uno", "dos", "tres"}, "--ansi")
    if result then
      SendFidgetNotification(result[1])
    end
  end)
  WaitForCoroutine(routine, function()
    routine = coroutine.create(function ()
      local result = fzf.fzf({"cuatro", "cinco", "seis"}, "--ansi")
      if result then
        SendFidgetNotification(result[1])
      end
    end)
  end)
end

function VisualToText()
  local start_row, start_col, end_row, end_col = vim.fn.getpos("'<")[2], vim.fn.getpos("'<")[3], vim.fn.getpos("'>")[2], vim.fn.getpos("'>")[3]
  local lines = vim.fn.getline(start_row, end_row)
  local selected_characters = string.sub(lines[1], start_col, end_col)
  return selected_characters
end

function FZFRegisters()
  local fzf = require('fzf')
  local reg = vim.fn.getregtype(vim.v.register)
  local res = fzf.fzf({vim.fn.getreg(vim.v.register)}, "--ansi")
end

function WriterMode()
  vim.opt.linebreak = false
  vim.opt.wrap = true
  vim.opt.foldcolumn = "9"
  vim.opt.ruler = false
  vim.opt.relativenumber = false
  vim.opt.number = false
end

function OpenGodot()
  -- open godot on the folder where nvim was open first
  -- vim.fn.jobstart({"godot", vim.fn.getcwd()})
  vim.cmd("w")
  vim.cmd("!godot")
end

function SaveSessionAndExit()
  vim.cmd('mksession! .vimsession')
  vim.cmd('qa!')
end

vim.api.nvim_command("cnoreabbrev qs lua SaveSessionAndExit()<cr>")
vim.api.nvim_command("cnoreabbrev mks mksession! .vimsession<cr>")
