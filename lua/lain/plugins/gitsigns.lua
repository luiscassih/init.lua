return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', 'gn', function()
          if vim.wo.diff then
            vim.cmd.normal({'gn', bang = true})
          else
            gs.nav_hunk('next')
          end
        end, { desc = "Git Next Hunk" })

        map('n', 'gN', function()
          if vim.wo.diff then
            vim.cmd.normal({'gN', bang = true})
          else
            gs.nav_hunk('prev')
          end
        end, { desc = "Git Previous Hunk" })

        -- Actions
        map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', { desc = "Git Stage Hunk" })
        map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', { desc = "Git Reset Hunk" })
        map({ 'n', 'v' }, '<leader>ghv', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Git Select Hunk" })
        map('n', '<leader>ghS', gs.stage_buffer, { desc = "Git Stage Buffer" })
        map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = "Git Unstage Hunk" })
        map('n', '<leader>ghR', gs.reset_buffer, { desc = "Git Reset Buffer" })
        map('n', '<leader>ghp', gs.preview_hunk, { desc = "Git Preview Hunk" })
        map('n', '<leader>ghb', function() gs.blame_line { full = true } end, { desc = "Git Blame Line" })
        map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = "Git Toggle Current Line Blame" })
        map('n', '<leader>ghd', gs.diffthis, { desc = "Git Diff" })
        map('n', '<leader>ghD', function() gs.diffthis('~') end, { desc = "Git Diff Index" })
        map('n', '<leader>gtd', gs.toggle_deleted, { desc = "Git Toggle Deleted" })
      end
    }
  end
}
