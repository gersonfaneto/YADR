local base = require("utils.base")

local M = {}

base.mappings.bulk_register({
  {
    mode = { "n" },
    lhs = "<leader>nw",
    rhs = ":Neorg workspace<CR>",
    description = "Go to the default workspace - 'Notes'.",
  },
  {
    mode = { "n" },
    lhs = "<leader>ni",
    rhs = ":Neorg index<CR>",
    description = "Open current workspace index.",
  },
  {
    mode = { "n" },
    lhs = "<leader>nr",
    rhs = ":Neorg return<CR>",
    description = "Return to the previous point.",
  },
}, { options = { noremap = true, silent = true }, prefix = "Neorg: " })

return M
