return {
  "luiscassih/AniMotion.nvim",
  -- dir = "/mnt/DATA/bkup_fedora_before_nuke/dev/AniMotion/",
  enabled = true,
  event = "VeryLazy",
  config = function()
    require("AniMotion").setup({
      -- mode = "helix",
      clear_keys = { "<C-c>" },
      -- color = "Visual",
      -- color = { bg = "#FF00FF" },
    })
  end
}
