local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') });
end)

function SearchYanked()
    local yanked = vim.fn.getreg('"');
    builtin.grep_string({ search = yanked });
end

vim.keymap.set('v', '<leader>s', "y:lua SearchYanked()<cr>")

-- local telescope = require('telescope').load_extension("file_browser")
-- vim.keymap.set('n', '<leader>lf', telescope.file_browser({ path = vim.fn.expand("%:p:h"), select_buffer=true }), { noremap = true })
