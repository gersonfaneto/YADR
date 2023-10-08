return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local types = require("utils.types")
    local base = require("utils.base")

    local null_ls = require("null-ls")

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end
    end

    null_ls.setup({
      border = types.get_settings("float_border") and "double" or "none",
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.ocamlformat,

        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.diagnostics.shellcheck,
      },
      on_attach = types.get_settings("format_on_save") and on_attach or nil,
    })

    base.mappings.bulk_register({
      {
        mode = { "n" },
        lhs = "<leader>ni",
        rhs = ":NullLsInfo<CR>",
        options = { noremap = true, silent = true },
        description = "Open NoneLs Info.",
      },
      {
        mode = { "n", "v" },
        lhs = "<leader>lf",
        rhs = function()
          vim.lsp.buf.format()
        end,
        options = { noremap = true, silent = true },
        description = "Format current buffer.",
      },
    })
  end,
}
