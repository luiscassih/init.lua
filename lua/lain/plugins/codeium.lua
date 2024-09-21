return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  enabled = false,
  config = function()
    vim.keymap.set('i', '<c-l>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    vim.keymap.set('i', '<c-j>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<c-k>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    vim.g.codeium_filetypes = {
      markdown = false
    }
  end
}
