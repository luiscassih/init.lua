local query = require "vim.treesitter.query"
query.add_directive("substr!", function(match, _, _, pred, metadata)
    local capture_id = pred[2] --[[@as integer]]
    local nodes = match[capture_id]
    if not nodes or #nodes == 0 then
      return
    end
    assert(#nodes == 1, '#offset! does not support captures on multiple nodes')

    local node = nodes[1]

    if not metadata[capture_id] then
      metadata[capture_id] = {}
    end

    local range = metadata[capture_id].range or { node:range() }
    local start_col = pred[3] + 0
    local end_col = pred[4] + 0

    -- cast to number
    if start_col >= 0 and end_col <= range[4] then
      metadata[capture_id].range = {
        range[1],
        start_col,
        range[3],
        end_col
      }
    end
end, { force = true, all = true }) -- ERA ESTA MIERDA DE ALL

query.add_directive("find_set_range!", function(match, _, _, pred, metadata)
    local capture_id = pred[2] --[[@as integer]]
    local nodes = match[capture_id]
    if not nodes or #nodes == 0 then
      return
    end
    assert(#nodes == 1, '#look_for_range! does not support captures on multiple nodes')
    local node = nodes[1]
    if not metadata[capture_id] then
      metadata[capture_id] = {}
    end

    local range = metadata[capture_id].range or { node:range() }

    local search_text = pred[3]
    local text = vim.treesitter.get_node_text(node, 0)
    -- locate search_text in text and return the range
    local start = string.find(text, search_text, 1, true)
    if start then
      metadata[capture_id].range = {
        range[1],
        start - 1,
        range[3],
        start + string.len(search_text) - 1
      }
    end
end, { force = true, all = true })
