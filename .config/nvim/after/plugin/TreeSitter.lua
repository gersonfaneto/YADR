local pCall = require("Utils.ProtectedCall")

local TreeSitter = pCall("nvim-treesitter.configs")

TreeSitter.setup({
  ensure_installed = {
    "c",
    "cpp",
    "c_sharp",
    "rust",
    "lua",
    "python",
    "html",
    "css",
    "tsx",
    "javascript",
    "typescript",
    "fish",
    "json",
    "toml",
    "gitcommit",
    "gitignore",
  },
  sync_install = false,
  auto_install = true,
  auto_tag = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extented_mode = true,
    max_file_lines = nil,
  },
})
