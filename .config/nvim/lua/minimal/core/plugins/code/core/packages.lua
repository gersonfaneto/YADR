local M = {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  cmd = {
    "Mason",
  },
  event = {
    "BufReadPost",
  },
}

function M.config()
  local mason = require("mason")

  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
      border = "rounded",
    },
  })

  local packages = vim.tbl_flatten({
    vim.tbl_values(utils.types.packages.servers),
    vim.tbl_values(utils.types.packages.extensions.linters),
    vim.tbl_values(utils.types.packages.extensions.formatters),
  })

  local registry = require("mason-registry")

  for _, package in pairs(packages) do
    package = registry.get_package(package)

    if not package:is_installed() then
      package:install()
    end
  end
end

return M
