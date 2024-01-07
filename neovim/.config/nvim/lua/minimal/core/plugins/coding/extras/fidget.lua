local M = {
  "j-hui/fidget.nvim",
  branch = "legacy",
  event = { "LspAttach" },
}

function M.config()
  local commenced = "Started"
  local completed = "Completed"

  local M = {
    ignore_message = {
      "%d+ files to analyze",
    },
  }

  require("fidget").setup({
    window = {
      blend = 0,
    },
    text = {
      spinner = "meter",
      commenced = commenced,
      completed = completed,
    },
    fmt = {
      task = function(task_name, message, percentage)
        if message:match(completed) and not percentage then
          return
        end

        for _, rule in ipairs(M.ignore_message) do
          if message:match(rule) then
            return
          end
        end

        return string.format("%s%s [%s]", message, percentage and string.format(" (%s%%)", percentage) or "", task_name)
      end,
    },
  })
end

return M
