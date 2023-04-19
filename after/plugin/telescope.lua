local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input('Grep > ') });
end)

-- local telescope = require('telescope').load_extension("file_browser")
-- vim.keymap.set('n', '<leader>lf', telescope.file_browser({ path = vim.fn.expand("%:p:h"), select_buffer=true }), { noremap = true })
