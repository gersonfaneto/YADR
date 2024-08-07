local M = {
  "stevearc/oil.nvim",
  cmd = "Oil",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}

function M.init()
  if vim.fn.argc() == 1 then
    local arg = vim.fn.argv(0)
    local stat = vim.loop.fs_stat(arg)
    if vim.startswith(arg, "oil-ssh://") or stat and stat.type == "directory" then
      require("lazy").load({ plugins = { "oil.nvim" } })
    end
  end
  if not require("lazy.core.config").plugins["oil.nvim"]._.loaded then
    vim.api.nvim_create_autocmd("BufNew", {
      callback = function()
        if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
          require("lazy").load({ plugins = { "oil.nvim" } })
          -- Once `Oil` is loaded, we can delete this `autocmd`.
          return true
        end
      end,
    })
  end

  utils.base.mappings.bulk_register({
    {
      mode = { "n" },
      lhs = "-",
      rhs = ":Oil<CR>",
      description = "Open parent directory.",
    },
    {
      mode = { "n" },
      lhs = "<leader>-",
      rhs = ":Oil --float<CR>",
      description = "Open parent directory - Float.",
    },
  }, { options = { silent = true, noremap = true }, prefix = "Oil :: " })
end

function M.config()
  local oil = require("oil")

  oil.setup({
    skip_confirm_for_simple_edits = true,
    default_file_explorer = true,
    delete_to_trash = true,
    columns = {
      "icon",
    },
    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name, _)
        return name == '..' or name == '.git'
      end,
    },
    float = {
      max_height = 20,
      max_width = 60,
    },
    keymaps = {
      ["<C-s>"] = false,
      ["s"] = "actions.select_vsplit",
      ["<C-h>"] = false,
      ["h"] = "actions.select_split",
      ["<C-l>"] = false,
      ["R"] = "actions.refresh",
    },
  })
end

return M
