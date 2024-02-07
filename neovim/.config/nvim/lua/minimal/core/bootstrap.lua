local M = {}

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
  vim.notify("Downloading lazy.nvim ...", vim.log.levels.INFO, { title = "Lazy" })
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_path,
  })
end

vim.opt.rtp:prepend(lazy_path)

local ok, lazy = pcall(require, "lazy")

if not ok then
  vim.notify("Failed to download lazy.nvim ...", vim.log.levels.ERROR, { title = "Lazy" })
  return
end

local include_directories = {
  { import = "minimal.core.plugins.code.core" },
  { import = "minimal.core.plugins.code.extras" },
  { import = "minimal.core.plugins.code.languages" },
  { import = "minimal.core.plugins.editor" },
  { import = "minimal.core.plugins.interface" },
  { import = "minimal.core.plugins.navigation" },
  { import = "minimal.core.plugins.tools" },
  { import = "minimal.core.plugins.others" },
}

local customs = vim.fn.stdpath("config") .. "/lua/custom/plugins/"

if utils.base.files.is_directory(customs) then
  include_directories[#include_directories + 1] = { import = "custom.plugins" }
end

local lazy_options = {
  install = {
    missing = true,
    colorscheme = {
      "habamax",
    },
  },
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        -- "netrw",
        -- "netrwPlugin",
        -- "netrwSettings",
        -- "netrwFileHandlers",
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
}

lazy.setup(include_directories, lazy_options)

utils.base.mappings.bulk_register({
  {
    mode = { "n" },
    lhs = "<leader>lh",
    rhs = ":Lazy<CR>",
    description = "Home.",
  },
  {
    mode = { "n" },
    lhs = "<leader>lp",
    rhs = ":Lazy profile<CR>",
    description = "Profile.",
  },
}, { options = { silent = true, noremap = true }, prefix = "Lazy :: " })

return M
