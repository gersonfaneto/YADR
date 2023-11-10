return {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua" },
  event = { "InsertEnter" },
  cond = function()
    local types = require("minimal.utils.types")

    return types.settings.enhanced_coding
  end,
  config = function()
    local copilot_cmp = require("copilot_cmp")

    copilot_cmp.setup()
  end,
}
