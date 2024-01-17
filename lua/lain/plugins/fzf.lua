return {
  -- 'vijaymarupudi/nvim-fzf'
  'junegunn/fzf.vim',
  dependencies = {
  --   {
      'junegunn/fzf',
  --     dir = "~/.fzf", build = "./install --all",
  --   }
  },
  config = function()
    vim.keymap.set("n", "<C-p>", ":Files<CR>", { noremap = true })
    vim.keymap.set("n", "<C-b>", ":Buffers<CR>", { noremap = true })
    vim.keymap.set("n", "<C-f>", ":Rg<CR>", { noremap = true })
    vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden'
    vim.env.FZF_DEFAULT_OPTS = '--bind ctrl-e:select-all,ctrl-d:deselect-all'
    vim.g.fzf_preview_window = ''
    vim.g.fzf_layout = {
      down = '~40%',
    }
    local function build_quickfix_list(lines)
      vim.fn.setqflist(vim.tbl_map(function(line)
        return {filename = line}
      end, vim.deepcopy(lines)))
      vim.cmd("copen")
      -- vim.cmd("cc")
    end
    vim.g.fzf_action = {
      ['ctrl-s'] = 'split',
      ['ctrl-v'] = 'vsplit',
      ['ctrl-q'] = build_quickfix_list,
    }
  end,
}
