vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>h", '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "8j")
vim.keymap.set("n", "<C-u>", "8k")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "<C-o>", "<C-o>zz")
-- vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("t", "<C-c><C-c>", "<C-\\><C-n>")
vim.keymap.set("t", "H", "^")
vim.keymap.set("t", "L", "$")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>P", [["+p]])

-- prevent x and d to rewrite yanked register
vim.keymap.set("n", "x", [["_x]])
vim.keymap.set({ "n", "v" }, "d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["0d]])

vim.keymap.set({ "n", "v" }, "H", "^")
vim.keymap.set({ "n", "v" }, "L", "$")
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+ygv]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-p>", function()
    local fzf = "fd --type f --hidden --follow --exclude .git | fzf"
    local window_id = vim.fn.systemlist("tmux display-message -p \\#I")[1]
    -- local command = 'tmux display-popup -d "#{pane_current_path}" -w 100\\% -h 100\\% -E "fzf | xargs -I {} tmux send-keys -t ' .. window_id .. ' \\":edit {}\\" Enter"'
    -- TODO: instead of opening the file, copy the full path to clipboard, or yank
    -- That way we can use C-f to open a file and C-p to search look for a path to paste in any require or code
    -- use SendFidgetNotification when successfuly copied
    local command = 'tmux display-popup -d "#{pane_current_path}" -w 100\\% -h 100\\% -E "' .. fzf .. ' | xargs -I {} tmux send-keys -t ' .. window_id .. ' \\":edit {}\\" Enter"'
    os.execute(command)
end)
-- vim.keymap.del("n", "<leader>f")
vim.keymap.set("n", "<leader>lf", function()
    local cmd = "lfp " .. vim.fn.expand('%:p')
    local window_id = vim.fn.systemlist("tmux display-message -p \\#I")[1]
    local command = 'tmux display-popup -d "#{pane_current_path}" -w 100\\% -h 100\\% -E "' .. cmd  .. ' | xargs -I {} tmux send-keys -t ' .. window_id .. ' \\":edit {}\\" Enter"'
    os.execute(command)
end)

-- vim.keymap.set("n", "<C-s>", '<cmd>silent !tmux display-popup -E "tmux ls | fzf | awk \'{sub(/:.*/, \\"\\"); print $1}\' | xargs tmux switch -t"<CR>');
vim.keymap.set("n", "<C-s>", '<cmd>silent !tmux display-popup -w 100\\% -h 100\\% -E "ts"<CR>');
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

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

vim.cmd('command! -nargs=* Cmd :lua Cmd(<f-args>)')
vim.cmd('command! -nargs=0 CloseTerm :lua CloseTerm()')
vim.cmd('command! -nargs=0 W :w')


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

vim.cmd('command! -nargs=0 Tri :lua SplitTri()')

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

-- vim.api.nvim_exec([[
--   augroup QuickFixRemove
--     autocmd!
--     autocmd FileType qf nmap <buffer> dd :lua RemoveQFItem('n')<CR>
--     autocmd FileType qf vmap <buffer> d :lua RemoveQFItem('v')<CR>
--   augroup END
-- ]], true)
vim.api.nvim_command("autocmd FileType qf nnoremap <buffer> dd :lua RemoveQFItem('n')<cr>")
vim.api.nvim_command("autocmd FileType qf vnoremap <buffer> d :lua RemoveQFItem('v')<cr>")

vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux display-popup -d "\\#{pane_current_path}"<cr>')
vim.keymap.set('n', '<leader>nt', ':Neotree<cr>')
vim.keymap.set('n', '<leader>o', ':Oil<cr>')
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', 'y', 'ygv', { noremap = true })
