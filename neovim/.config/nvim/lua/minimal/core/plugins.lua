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
  { import = "minimal.core.plugins.coding" },
  { import = "minimal.core.plugins.coding.extras" },
  { import = "minimal.core.plugins.editing" },
  { import = "minimal.core.plugins.exploring" },
  { import = "minimal.core.plugins.spelling" },
  { import = "minimal.core.plugins.tooling" },
  { import = "minimal.core.plugins.viewing" },
}

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
