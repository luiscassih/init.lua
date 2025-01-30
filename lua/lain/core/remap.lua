vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
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

-- vim.keymap.set("t", "<C-c><C-c>", "<C-\\><C-n>")
-- Use once to exit, and twice to send C-c (cancel command)
vim.keymap.set("t", "<C-c>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-c><C-c>", "<C-c>")

-- vim.keymap.set("t", "H", "^")
-- vim.keymap.set("t", "L", "$")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>P", [["+p]])

-- prevent x to rewrite yanked register
vim.keymap.set({ "n", "v" }, "x", [["_x]])

-- uncomment this to have d the same as x
-- vim.keymap.set({ "n", "v" }, "d", [["_d]])
-- vim.keymap.set({ "n", "v" }, "c", [["_c]])
-- vim.keymap.set({ "n", "v" }, "<leader>d", [["0d]])

-- have leader d to do the same as x
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- vim.keymap.set({ "n", "v" }, "H", "^")
-- vim.keymap.set({ "n", "v" }, "L", "$")
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+ygv]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
--[[
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
--]]
-- vim.keymap.del("n", "<leader>f")
-- vim.keymap.set("n", "<leader>lf", function()
--     local cmd = "lfp " .. vim.fn.expand('%:p')
--     local window_id = vim.fn.systemlist("tmux display-message -p \\#I")[1]
--     local command = 'tmux display-popup -d "#{pane_current_path}" -w 100\\% -h 100\\% -E "' .. cmd  .. ' | xargs -I {} tmux send-keys -t ' .. window_id .. ' \\":edit {}\\" Enter"'
--     os.execute(command)
-- end)

-- vim.keymap.set("n", "<C-s>", '<cmd>silent !tmux display-popup -E "tmux ls | fzf | awk \'{sub(/:.*/, \\"\\"); print $1}\' | xargs tmux switch -t"<CR>');

-- removed, using binding directly in tmux conf
-- vim.keymap.set("n", "<C-s>", '<cmd>silent !tmux display-popup -w 100\\% -h 40\\% -E "ts"<CR>');

-- vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- My own solution to Ctrl-D implementation of substitution, it uses the x register to store the word
-- vim.keymap.set("n", "<leader>s", [[:let @x = "<C-r><C-w>"<Enter>V]])
-- s will replace the coincidence, even if it's part of another word
-- vim.keymap.set("v", "<leader>s", [[:s/<C-r>x//g<Left><Left>]])
-- S will replace only words, ideal for refactor a variable only in that visual block
-- vim.keymap.set("v", "<leader>S", [[:s/\<<C-r>x\>//g<Left><Left>]])

-- this is the same but it will overwrite the default yanked register
-- vim.keymap.set("n", "<leader>s", [[yiwV]])
-- vim.keymap.set("v", "<leader>s", [[:s/<C-r>0/]])

vim.cmd('command! -nargs=* Cmd :lua Cmd(<f-args>)')
vim.cmd('command! -nargs=0 CloseTerm :lua CloseTerm()')
vim.cmd('command! -nargs=0 W :w')

vim.cmd('command! -nargs=0 Tri :lua SplitTri()')

-- yank ñ to the clipboard
-- vim.cmd('command! -nargs=0 Enie :call setreg("+", "ñ")')
vim.cmd('command! -nargs=0 Enie :let @+ = "ñ"')
vim.cmd('command! -nargs=0 EnieN :let @+ = "Ñ"')
-- copy ñ
vim.keymap.set("n", "<leader>cn", ":Enie<CR>")
vim.keymap.set("n", "<leader>cN", ":EnieN<CR>")

-- vim.api.nvim_exec([[
--   augroup QuickFixRemove
--     autocmd!
--     autocmd FileType qf nmap <buffer> dd :lua RemoveQFItem('n')<CR>
--     autocmd FileType qf vmap <buffer> d :lua RemoveQFItem('v')<CR>
--   augroup END
-- ]], true)
vim.api.nvim_command("autocmd FileType qf nnoremap <buffer> dd :lua RemoveQFItem('n')<cr>")
vim.api.nvim_command("autocmd FileType qf vnoremap <buffer> d :lua RemoveQFItem('v')<cr>")
vim.api.nvim_command("autocmd FileType gdscript setlocal tabstop=4 shiftwidth=4 foldmethod=expr indentexpr= noexpandtab")

-- vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux display-popup -d "\\#{pane_current_path}"<cr>')
-- maximize a terminal buffer, open if not exists
-- vim.keymap.set('n', '<C-t>', function ()
--   local bufnr = GetTermBuffer()
--   if bufnr ~= nil then
--     local winid = vim.fn.bufwinid(bufnr)
--     if winid ~= -1 then
--       -- terminal buffer window exist, so focus
--       vim.api.nvim_set_current_win(winid)
--     else
--       -- If the terminal buffer exists but is not currently open in any window,
--       -- open it in a new split
--       vim.cmd('wincmd l') -- make sure we are at right window
--       vim.cmd("split")
--       vim.cmd('wincmd j')
--       vim.api.nvim_set_current_buf(bufnr)
--     end
--     -- after focusing of a terminal, maximize it
--     vim.cmd("MaximizerToggle")
--     return
--   end
--   -- there's no terminal, so open it
--   vim.cmd('wincmd l')
--   vim.cmd("split")
--   vim.cmd('wincmd j')
--   vim.cmd("term")
--   vim.cmd("MaximizerToggle")
-- end)

-- vim.keymap.set('n', '<leader>lf', ':Neotree<cr>')
vim.keymap.set('n', '>>', '<C-w>10>', { noremap = true })
vim.keymap.set('n', '<<', '<C-w>10<', { noremap = true })
vim.keymap.set('n', '<C-w>,', '<C-w>5+', { noremap = true })
vim.keymap.set('n', '<C-w>.', '<C-w>5-', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', 'y', 'ygv', { noremap = true })

-- View help for the word under the cursor
vim.keymap.set('n', '<leader>vh', [[:h <C-r><C-w><Enter>]], { noremap = true })

vim.keymap.set('n', '<leader>q', function ()
  if vim.bo[0].buftype == "quickfix" then
  -- if vim.api.nvim_buf_get_option(0, "buftype") == "quickfix" then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end)

-- add this file location to the end of quickfix list
vim.keymap.set('n', '<leader>a', function ()
  AddQFItem(vim.fn.expand("%:p"))
end)

-- Let's make it easier to move in wrapped lines
vim.keymap.set('n', 'j', [[v:count? 'j' : 'gj']], { noremap = true, expr = true })
vim.keymap.set('n', 'k', [[v:count? 'k' : 'gk']], { noremap = true, expr = true })

-- cd to current file
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>')

vim.keymap.set({'n', 'v'}, '<c-a>', '<esc>[[ggVG]]')

vim.keymap.set('i', '<S-tab>', '<c-d>')

-- Remap macro recording to 'Q' instead of 'q'
-- vim.keymap.set('n', 'q', '<nop>', {})
vim.keymap.set('n', 'Q', 'q', { desc = 'Record macro', noremap = true })

vim.keymap.set('n', '<bs>', '<C-^>')
