local M = {}

--- Used to retrieve the value of a given setting used across the other modules. Overrides must be
--- placed under `custom.settings` following the pattern of the default file
--- `core.settings`.
---
--- @param key string The name of the setting to be retrieved.
--- @return string | boolean | nil value The setting corresponding to the given key.
M.get_settings = function(key)
  local defaults = require("core.settings")
  local has_custom, custom = pcall(require, "custom.settings")

  local default_value = vim.tbl_get(defaults, key)

  if default_value == nil then
    return nil
  end

  if has_custom then
    local custom_value = vim.tbl_get(custom, key)

    if custom_value ~= nil then
      return custom_value
    end
  end

  return default_value
end

return M