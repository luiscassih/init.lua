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

local getTermBuffer = function ()
  for _, buf in ipairs(vim.fn.getbufinfo()) do
    if vim.fn.bufname(buf.bufnr):match("term://") then
      return buf.bufnr
    end
  end
end

function SendKeysToTerm(commands)
  local buf = getTermBuffer()
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
