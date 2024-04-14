local base = require("minimal.utils.base")

local M = {}

function M.register(bufnr)
  base.mappings.bulk_register({
    {
      mode = { "n", "v" },
      lhs = "<leader>la",
      rhs = function()
        vim.lsp.buf.code_action({
          context = {
            only = { "quickfix", "refactor", "source" },
          },
        })
      end,
      description = "Show code actions.",
    },
    {
      mode = { "n" },
      lhs = "<leader>rn",
      rhs = vim.lsp.buf.rename,
      description = "Rename symbol under cursor.",
    },
    {
      mode = { "n" },
      lhs = "K",
      rhs = vim.lsp.buf.hover,
      description = "Show help information.",
    },
    {
      mode = { "n", "i" },
      lhs = "<C-s>",
      rhs = vim.lsp.buf.signature_help,
      description = "Signature Documentation",
    },
    {
      mode = { "n" },
      lhs = "gr",
      rhs = vim.lsp.buf.references,
      description = "Browse references.",
    },
    {
      mode = { "n" },
      lhs = "gi",
      rhs = vim.lsp.buf.implementation,
      description = "Browse implementations.",
    },
    {
      mode = { "n" },
      lhs = "gd",
      rhs = vim.lsp.buf.definition,
      description = "Go to definition.",
    },
    {
      mode = { "n" },
      lhs = "gD",
      rhs = vim.lsp.buf.declaration,
      description = "Go to declaration.",
    },
    {
      mode = { "n" },
      lhs = "vd",
      rhs = ":vsplit | lua vim.lsp.buf.definition()<CR>",
      description = "Split and go to definition.",
    },
    {
      mode = { "n" },
      lhs = "vD",
      rhs = ":vsplit | lua vim.lsp.buf.declaration()<CR>",
      description = "Split and go to declaration.",
    },
    {
      mode = { "n" },
      lhs = "of",
      rhs = vim.diagnostic.open_float,
      description = "Open diagnostic float.",
    },
    {
      mode = { "n" },
      lhs = "dl",
      rhs = vim.diagnostic.setqflist,
      description = "View diagnostics in QuickFix list.",
    },
    {
      mode = { "n" },
      lhs = "[d",
      rhs = vim.diagnostic.goto_prev,
      description = "Jump to previous diagnostic.",
    },
    {
      mode = { "n" },
      lhs = "]d",
      rhs = vim.diagnostic.goto_next,
      description = "Jump to next diagnostic.",
    },
  }, { options = { noremap = true, silent = true, buffer = bufnr }, prefix = "LSP :: " })
end

return M
