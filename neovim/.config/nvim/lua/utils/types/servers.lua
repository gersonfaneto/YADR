local M = {}

M.lsp = {
  "bashls", -- Bash
  "clangd", -- C/C++
  "cssls", -- CSS
  "emmet_ls", -- HTML
  "gopls", -- Go
  "html", -- HTML
  "jdtls", -- Java
  "lua_ls", -- Lua
  "ocamllsp", -- OCaml
  "pyright", -- Python
  "rust_analyzer", -- Rust
  "svelte", -- Svelte
  "tailwindcss", -- TailwindCSS
  "tsserver", -- TypeScript / JavaScript
}

M.linters = {
  "eslint_d", -- *
  "pylint", -- Python
  "shellcheck", -- Bash/Shell
}

M.formatters = {
  "black", -- Python
  "clang-format", -- C/C++
  "google-java-format", -- Java
  "isort", -- Python
  "ocamlformat", -- OCaml
  "prettier", -- *
  "shfmt", -- Bash|Shell
  "stylua", -- Lua
}

return M
