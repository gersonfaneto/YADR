local M = {
  "echasnovski/mini.pairs",
  event = { "VeryLazy" },
}

function M.config(_, opts)
  local mini_pairs = require("mini.pairs")

  mini_pairs.setup(opts)
end

return M
