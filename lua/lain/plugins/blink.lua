return {
  'saghen/blink.cmp',
  event = { "LspAttach", "InsertCharPre" },
  enabled = true,
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',
  -- use a release tag to download pre-built binaries
  -- version = 'v0.*',
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  build = 'cargo build --release',

  opts = {
    highlight = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = true,
    },
    -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'normal',
    -- experimental auto-brackets support
    accept = { auto_brackets = { enabled = true } },
    -- experimental signature help support
    trigger = { signature_help = { enabled = true } },
    keymap = {
      preset = 'default',
      -- show = '<C-h>',
      ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
      -- hide = '<C-e>',
      ['<C-e>'] = { 'hide' },
      ['<CR>'] = { 'accept', 'fallback' },
      -- ['<Tab>'] = { 'select_and_accept' },
      -- select_prev = { '<C-p>' },
      -- select_next = { '<C-n>' },

      -- show_documentation = {},
      -- hide_documentation = {},
      -- scroll_documentation_up = '<C-u>',
      -- scroll_documentation_down = '<C-d>',
      -- snippet_forward = '<c-,>',
      -- snippet_backward = '<c-.>',

      ['<C-,>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-.>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-u>'] = { 'snippet_forward', 'fallback' },
      ['<C-d>'] = { 'snippet_backward', 'fallback' },
    },
    windows = {
      autocomplete = {
        max_height = 15,
        -- draw = "reversed",
        selection = 'auto_insert',
      }
    },
  },
  -- allows extending the enabled_providers array elsewhere in your config
  -- without having to redefining it
  opts_extend = { "sources.completion.enabled_providers" }
}
