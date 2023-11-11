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


-- function Marks()
--   local marks = vim.fn.execute('marks "')
--   for _, line in ipairs(vim.fn.split(marks, '\n')) do
--     local mark, file_path = line:match('^%s*([a-zA-Z0-9%%<>.]+)%s+(.+)$')
--     if mark and file_path then
--       local fzf_command = string.format('FZF_DEFAULT_OPTS="--preview \'bat --color=always --style=header,grid --line-range :100 {}\'" rg --files --no-ignore --hidden %s', vim.fn.shellescape(file_path))
--       -- Run the FZF command and get the selected file
--       local selected_file = vim.fn.systemlist(fzf_command)[1]
--       -- If a file is selected, open it in a new buffer
--       if selected_file then
--         -- vim.cmd('edit ' .. selected_file)
--         print('file: '.. selected_file)
--       end
--     end
--   end
-- end


-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)
-- vim.keymap.set('n', 'gs', '<Plug>(leap-from-window)', { noremap = true })
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux display-popup -d "\\#{pane_current_path}"<cr>')
vim.keymap.set('n', '<leader>nt', ':Neotree<cr>')
vim.keymap.set('n', '<leader>o', ':Oil<cr>')
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', 'y', 'ygv', { noremap = true })
