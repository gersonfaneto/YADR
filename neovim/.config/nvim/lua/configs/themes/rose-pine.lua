local settings = require("core.settings")

local M = {
  requires = {
    "rose-pine",
  },
}

function M.before() end

function M.load()
  M.rose_pine.setup({
    variant = "auto",
    dark_variant = "main",
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = settings.transparent,
    disable_float_background = settings.transparent,
    disable_italics = false,

    groups = {
      background = "base",
      background_nc = "_experimental_nc",
      panel = "surface",
      panel_nc = "base",
      border = "highlight_med",
      comment = "muted",
      link = "iris",
      punctuation = "subtle",

      error = "love",
      hint = "iris",
      info = "foam",
      warn = "gold",

      headings = {
        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },
    },

    highlight_groups = {
      ColorColumn = { bg = "rose" },

      CursorLine = { bg = "foam", blend = 10 },
      StatusLine = { fg = "love", bg = "love", blend = 10 },
    },
  })
end

function M.after()
  vim.cmd("colorscheme rose-pine")
end

return M