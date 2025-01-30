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

function AddQFItem(path)
  vim.fn.setqflist({
    {
      bufnr = vim.fn.bufnr(path),
      text = path
    }
  }, 'a')
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

function AskNewFile()
  vim.ui.input({ prompt = "New file name: " }, function(input)
    vim.cmd("new %:h/" .. input)
  end)
end

vim.api.nvim_command("cnoreabbrev qs lua SaveSessionAndExit()<cr>")
vim.api.nvim_command("cnoreabbrev mks mksession! .vimsession<cr>")
vim.api.nvim_command("cnoreabbrev newhere lua AskNewFile()<cr>")


-- quotes motion
local function find_closest_quote()
    local line = vim.fn.getline('.')
    local col = vim.fn.col('.')
    local single_quote = line:find("'", col)
    local double_quote = line:find('"', col)
    if single_quote and double_quote then
        return single_quote < double_quote and "'" or '"'
    elseif single_quote then
        return "'"
    elseif double_quote then
        return '"'
    else
        return nil
    end
end

local function quote_motion(motion_type)
    local quote = find_closest_quote()
    if quote then
        vim.cmd('normal! f'.. quote .. motion_type .. quote)
    end
end

-- Operator-pending mode mappings
vim.keymap.set('o', 'iq', function() quote_motion('vi') end, {silent = true, desc = "Select inside closest quote"})
vim.keymap.set('o', 'aq', function() quote_motion('va') end, {silent = true, desc = "Select around closest quote"})

-- Visual mode mappings
vim.keymap.set('x', 'iq', function() quote_motion('i') end, {silent = true, desc = "Select inside closest quote"})
vim.keymap.set('x', 'aq', function() quote_motion('a') end, {silent = true, desc = "Select around closest quote"})

-- Normal mode mappings to initiate visual selection
vim.keymap.set('n', 'viq', function() quote_motion('vi') end, {silent = true, desc = "Select inside closest quote"})
vim.keymap.set('n', 'vaq', function() quote_motion('va') end, {silent = true, desc = "Select around closest quote"})

-- Find and select the closest parameter under cursor
-- NOT WORKING
local function find_closest_param()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]

    -- Get the current line up to cursor and after cursor
    local before_cursor = line:sub(1, col + 1)
    local after_cursor = line:sub(col + 1)

    -- Detect context
    local context = "none"
    local before_clean = before_cursor:gsub("%s+", "") -- remove spaces for easier pattern matching

    -- Check for class context (="...)
    if before_clean:match("=[\"'][^\"']*$") then
        context = "class"
    -- Check for arrow function ((param: type) =>)
    elseif before_clean:match("=>.*%(.*$") or before_clean:match("=>[^%(]*$") then
        context = "arrow_function"
    -- Check for regular function (word(...))
    elseif before_clean:match("[%w_]+%(.*$") then
        context = "function"
    -- Check for object context ({key = value})
    elseif before_clean:match("{[^}]*$") then
        context = "object"
    end
    print(context)

    -- Find initial boundaries
    local left_pos = before_cursor:reverse():find("[,%s\"'%({%[]")
    if not left_pos then
        left_pos = 0
    end
    left_pos = #before_cursor - left_pos + 1

    local right_pos = after_cursor:find("[,%s\"'%)%}%]]")
    if not right_pos then
        right_pos = #after_cursor
    else
        right_pos = col + right_pos
    end

    -- Adjust boundaries based on context
    if context == "function" or context == "arrow_function" then
        -- Check for trailing comma first
        local has_trailing_comma = line:sub(right_pos, right_pos) == ","
        if has_trailing_comma then
          print("has trailing comma")
            -- Include the trailing comma in selection
            right_pos = right_pos
            left_pos = left_pos + 1
        else
            -- Check for leading comma
            local has_leading_comma = line:sub(left_pos, left_pos) == ","
            if has_leading_comma then
                -- Include the leading comma in selection
                left_pos = left_pos
            else
                -- No comma, just select the word
                if line:sub(left_pos, left_pos):match("%s") then
                    left_pos = left_pos + 1
                end
                if line:sub(right_pos, right_pos):match("%s") then
                    right_pos = right_pos - 1
                end
            end
        end
    elseif context == "class" then
        -- Check for trailing space first
        if line:sub(right_pos, right_pos):match("%s") then
            left_pos = left_pos + 1
            right_pos = right_pos
        -- If no trailing space, check for leading space
        elseif line:sub(left_pos, left_pos):match("%s") then
            -- Keep left_pos as is to include the leading space
            left_pos = left_pos
            right_pos = right_pos - 1
        -- No spaces at all
        else
            left_pos = left_pos + 1  -- Skip the quote
            right_pos = right_pos - 1
        end
    elseif context == "object" then
        -- For objects, check if we're in a string
        if line:sub(left_pos, left_pos):match("[\"']") then
            -- Handle like class context
            left_pos = left_pos + 1
            if right_pos > 0 then
                right_pos = right_pos - 1
            end
        else
            -- Look for = and extend until comma if found
            local has_equals = after_cursor:match("^[^,%)%}]*=")
            if has_equals then
                local next_comma = after_cursor:find("[,%)%}%]]")
                if next_comma then
                    right_pos = col + next_comma
                end
            end
        end
    end

    -- Set visual selection
    vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), left_pos - 1})
    vim.cmd('normal! v')
    vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), right_pos - 1})
end

-- Function to handle parameter motion in different modes
local function param_motion(motion_type)
    find_closest_param()
end

-- Normal mode mapping to initiate visual selection
-- vim.keymap.set('n', 'q', function() param_motion('v') end, {silent = true, desc = "Select closest parameter"})
--
-- -- Visual mode mapping
-- vim.keymap.set('x', 'q', function() param_motion('') end, {silent = true, desc = "Select closest parameter"})
--
-- -- Operator-pending mode mapping
-- vim.keymap.set('o', 'q', function() param_motion('v') end, {silent = true, desc = "Select closest parameter"})

local function incremental_backward_word_selection(motion_type)
  -- Get current position
  local line = vim.api.nvim_get_current_line()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1], cursor_pos[2]

  -- Initialize visual mode if needed
  if motion_type == 'v' then
    -- Store the current position as a mark for extending selection
    vim.cmd('normal! ml')
    vim.cmd('normal! viw')
    return
  end

  -- Get the current visual selection boundaries
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_col = start_pos[3]

  -- Get text before the selection
  local text_before = string.sub(line, 1, start_col - 1)

  -- Find the previous word boundary
  local pattern = "()%s*[%w_]+%s*[,]?%s*$"
  local match_start = text_before:match(pattern)

  if match_start then
    -- Extend selection to include the found pattern
    vim.cmd('normal! o')
    vim.cmd('normal! ' .. match_start .. '|')
  end
end

-- vim.keymap.set('n', 'q', function() incremental_backward_word_selection('v') end, {silent = true, desc = "Incremental word selection"})
-- vim.keymap.set('x', 'q', function() incremental_backward_word_selection('') end, {silent = true, desc = "Incremental word selection"})

vim.api.nvim_create_user_command("Align", function(opts)
  local start_line = opts.line1
  local end_line = opts.line2
  local col = tonumber(opts.args) or 1

  -- Save cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  for line = start_line, end_line do
    vim.api.nvim_win_set_cursor(0, {line, 0})
    -- from https://stackoverflow.com/a/8363443 it will go to beginning
    -- find = add 100 spaces  is <Esc> (used c-v to insert the code)
    -- then go the col cuantity of column with | and dw
    vim.cmd('normal! 0f=100i ' .. col .. '|dw')
  end

  -- Restore cursor position
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end, { range = true, nargs = "?" })
