return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup({
      delete_to_trash = true,
      default_file_explorer = true,
      use_default_keymaps = false,
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ['gd'] = "actions.select",
        ['g?'] = "actions.show_help",
        ['go'] = "actions.parent",
        ['gg'] = "actions.open_cwd",
        ['cd'] = "actions.tcd",
        ['gh'] = "actions.toggle_hidden",
        ['gs'] = "actions.select_vsplit",
        ['gS'] = "actions.select_split",
        ['gp'] = "actions.preview",
      },
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 100,
        max_height = 50,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "auto",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          local width_percentage = 0.2
          local height_percentage = 0.8
          local padding = 8

          conf.width = math.floor(vim.o.columns * width_percentage)
          conf.height = math.floor(vim.o.lines * height_percentage)
          conf.row = math.floor((vim.o.lines - conf.height) / 3)  -- center vertically
          conf.col = padding
          conf.style = "minimal"
          return conf
        end,
      },
    })

    -- Store the last directory
    local last_dir = nil

    -- Function to toggle float with memory
    local function toggle_float_with_memory()
      if vim.bo.filetype == 'oil' then
        last_dir = require('oil').get_current_dir()
        require('oil').close()
      else
        require('oil').toggle_float(last_dir)
      end
    end

    -- Function to open Oil in current file's directory
    local function open_file_dir()
      local current_file = vim.fn.expand('%:p')
      if current_file ~= '' then
        local file_dir = vim.fn.fnamemodify(current_file, ':h')
        require('oil').toggle_float(file_dir)
      else
        require('oil').toggle_float()
      end
    end

    -- Keymaps
    vim.keymap.set('n', "'", toggle_float_with_memory)
    vim.keymap.set('n', '"', open_file_dir)
    vim.keymap.set('n', '<leader>o', "<cmd>Oil<cr>")
  end
}
