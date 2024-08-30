return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.4',
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
    vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>pM', builtin.marks, {})
    vim.keymap.set('n', '<leader>pk', builtin.keymaps, {})
    vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
    vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>pH', builtin.highlights, {})
    vim.keymap.set('n', '<leader>ps', builtin.lsp_document_symbols, {})
    vim.keymap.set('n', '<leader>pr', builtin.lsp_references, {})
    vim.keymap.set('n', '<leader>pd', builtin.diagnostics, {})
    vim.keymap.set('n', '<leader>pc', builtin.commands, {})
    vim.keymap.set('n', '<leader>pt', builtin.filetypes, {})
    vim.keymap.set('n', '<leader>pp', builtin.registers, {})
    -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>pG', function()
      builtin.grep_string({ search = vim.fn.input('Grep > ') });
    end)

    function SearchYanked()
      local yanked = vim.fn.getreg('"');
      builtin.grep_string({ search = yanked });
    end

    vim.keymap.set('v', '<leader>/', "y:lua SearchYanked()<cr>")

    local telescope = require('telescope')
    local layout_config = {
      width = 0.99,
      height = 0.99,
      prompt_position = 'bottom',
      preview_width = 0.3,
    }

    telescope.setup({
      pickers = {
        find_files = {
          layout_config = layout_config,
        },
        git_files = {
          layout_config = layout_config,
        },
        buffers = {
          layout_config = layout_config,
        },
        live_grep = {
          layout_config = layout_config,
        },
        git_status = {
          layout_config = layout_config,
        },
      },
    })

    telescope.load_extension "file_browser"
    telescope.load_extension "harpoon"
    vim.keymap.set('n', '<leader>fb', ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {})
    vim.keymap.set('n', '<leader>pm', ":Telescope harpoon marks<CR>", {})

    -- local telescope = require('telescope').load_extension("file_browser")
    -- vim.keymap.set('n', '<leader>lf', telescope.file_browser({ path = vim.fn.expand("%:p:h"), select_buffer=true }), { noremap = true })
  end
}
