return
{
    -- dir = "~/dev/multicursor-nvim/",
    "jake-stewart/multicursor.nvim",
    enabled = true,
    config = function()
        local mc = require("multicursor-nvim")

        mc.setup()

        -- use MultiCursorCursor and MultiCursorVisual to customize
        -- additional cursors appearance
        vim.cmd.hi("link", "MultiCursorCursor", "Cursor")
        vim.cmd.hi("link", "MultiCursorVisual", "Visual")

        vim.keymap.set("n", "<c-c>", function()
            if mc.hasCursors() then
                mc.clearCursors()
            else
                -- default
                local k = vim.api.nvim_replace_termcodes("<C-c>", true, false, true)
                vim.api.nvim_feedkeys(k, "n", false)
            end
        end)
        -- vim.keymap.set("n", "<c-c>", [[mc.hasCursors? mc.clearCursors() : <c-c>]], {expr = true})

        -- add cursors above/below the main cursor
        vim.keymap.set({"n", "v"}, "<c-up>", function() mc.addCursor("k") end)
        vim.keymap.set({"n", "v"}, "<c-down>", function() mc.addCursor("j") end)

        -- add a cursor and jump to the next word under cursor
        vim.keymap.set({"n", "v"}, "<leader>s", function() mc.addCursor("*") end)
        -- vim.keymap.set({"n", "v", "x"}, "<leader>s", function() vim.cmd.norm("*") end)

        -- jump to the next word under cursor but do not add a cursor
        -- vim.keymap.set("n", "<c-s>", function() mc.skipCursor("*") end)

        -- add and remove cursors with control + left click
        -- vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
    end,
}