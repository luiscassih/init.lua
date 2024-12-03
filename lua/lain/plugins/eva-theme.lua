return {
  'sharpchen/Eva-Theme.nvim',
  lazy = false,
  priority = 1000,
  enabled = false,
  build = ':EvaCompile',
  config = function()
    require('Eva-Theme').setup({
      override_palette = {
        dark = {
          background = '#0b0b12',
        },
      },
      override_highlight = {
        dark = {
          ['@variable.tsx'] = { fg = '#f0f0f0' },
          ['@tag'] = { fg = '#6495ee' },
          ['@lsp.typemod.variable'] = { fg = '#f0f0f0' },
          ['@lsp.typemod.variable.defaultLibrary'] = { fg = '#f02b77' },
          WinSeparator = { fg = '#191926' },
        },
      },
    })
    vim.cmd.colorscheme('Eva-Dark')
  end
}
