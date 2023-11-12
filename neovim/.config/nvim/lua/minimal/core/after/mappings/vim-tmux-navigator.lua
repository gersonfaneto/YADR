local base = require("minimal.utils.base")

local M = {}

if os.getenv("TMUX") ~= nil then
  base.mappings.bulk_register({
    {
      mode = { "n" },
      lhs = "<C-Left>",
      rhs = ":TmuxNavigateLeft<CR>",
      description = "Go to the left.",
    },
    {
      mode = { "n" },
      lhs = "<C-Down>",
      rhs = ":TmuxNavigateDown<CR>",
      description = "Go to the bottom.",
    },
    {
      mode = { "n" },
      lhs = "<C-Up>",
      rhs = ":TmuxNavigateUp<CR>",
      description = "Go to the top.",
    },
    {
      mode = { "n" },
      lhs = "<C-Right>",
      rhs = ":TmuxNavigateRight<CR>",
      description = "Go to the right.",
    },
  }, { options = { silent = true, noremap = true }, prefix = "TMUX: " })
end

return M