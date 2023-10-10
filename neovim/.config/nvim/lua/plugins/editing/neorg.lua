return {
  "nvim-neorg/neorg",
  ft = { "norg" },
  cmd = { "Neorg" },
  event = { "BufReadPre", "BufNewFile" },
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local neorg = require("neorg")

    neorg.setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.summary"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              Notes = "~/Notes",
              Work = "~/Notes/Work",
              Study = "~/Notes/Study",
            },
            default_workspace = "Notes",
            index = "Main.norg",
          },
        },
      },
    })
  end,
}
