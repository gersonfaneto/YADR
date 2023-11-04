local types = require("utils.types")

local style = "default"

local decay = require("decay")
local decay_core = require("decay.core")
local decay_highlights = require("decay.highlights")

local colors = decay_core.get_colors(style)
local colors_override = types.settings.transparent and "NONE" or colors.background

local M = {}

decay.setup({
  style = style,
  cmp = {
    block_kind = false,
  },
  nvim_tree = {
    contrast = false,
  },
  italics = {
    code = true,
    comments = true,
  },
  palette_overrides = {
    background = colors_override,
  },
})

if types.get_settings("transparent") then
  decay_highlights.bulk_hi({
    NvimTreeNormal = { bg = "NONE" },
    NvimTreeNormalNC = { bg = "NONE" },
    NvimTreeEndOfBuffer = { bg = "NONE", fg = colors.contrast },
    NvimTreeEndOfBufferNC = { bg = "NONE", fg = colors.contrast },
    NvimTreeVertSplit = { fg = "NONE", bg = colors.background },
  })
end

return M
