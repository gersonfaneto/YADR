return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    lazy = false,
    dependencies = {
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
        dependencies = {
          "williamboman/mason-lspconfig.nvim",
          "WhoIsSethDaniel/mason-tool-installer.nvim"
        },
      },
      "onsails/lspkind.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local lsp = require("lsp-zero").preset("lsp-only")

      local settings = require("utils.api").settings
      local icons = require("utils.interface").icons

      local ensure_installed = {
        lsp = {
          "bashls",
          "clangd",
          "cssls",
          "emmet_ls",
          "gopls",
          "html",
          "jdtls",
          "lua_ls",
          "ocamllsp",
          "pyright",
          "rust_analyzer",
        },
        linters = {
          "eslint_d",
          "pylint",
          "shellcheck",
        },
        formatters = {
          "black",
          "clang-format",
          "isort",
          "ocamlformat",
          "prettier",
          "shfmt",
          "stylua",
        }
      }

      lsp.on_attach(function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        local api = require("utils.api")

        api.mappings.bulk_register({
          {
            mode = { "n", "v" },
            lhs = "<leader>la",
            rhs = vim.lsp.buf.code_action,
            options = opts,
            description = "Show code actions.",
          },
          {
            mode = { "n" },
            lhs = "<leader>rn",
            rhs = vim.lsp.buf.rename,
            options = opts,
            description = "Rename symbol under cursor.",
          },
          {
            mode = { "n" },
            lhs = "<leader>lf",
            rhs = function()
              vim.lsp.buf.format({ async = true })
            end,
            options = opts,
            description = "Format current buffer.",
          },
          {
            mode = { "n" },
            lhs = "K",
            rhs = vim.lsp.buf.hover,
            options = opts,
            description = "Show help information.",
          },
          {
            mode = { "n" },
            lhs = "gr",
            rhs = function()
              require("telescope.builtin").lsp_references()
            end,
            options = opts,
            description = "Go to references.",
          },
          {
            mode = { "n" },
            lhs = "gi",
            rhs = function()
              require("telescope.builtin").lsp_implementations()
            end,
            options = opts,

            description = "Go to implementations.",
          },
          {
            mode = { "n" },
            lhs = "gd",
            rhs = function()
              require("telescope.builtin").lsp_definitions()
            end,
            options = opts,
            description = "Go to definitions.",
          },
          {
            mode = { "n" },
            lhs = "gD",
            rhs = function()
              require("telescope.builtin").lsp_type_definitions()
            end,
            options = opts,
            description = "Go to type definitions.",
          },
          {
            mode = { "n" },
            lhs = "of",
            rhs = vim.diagnostic.open_float,
            options = opts,
            description = "Show current line diagnostic..",
          },
          {
            mode = { "n" },
            lhs = "<leader>ld",
            rhs = function()
              require("telescope.builtin").diagnostics()
            end,
            options = opts,
            description = "Show project diagnostics.",
          },
          {
            mode = { "n" },
            lhs = "[d",
            rhs = vim.diagnostic.goto_prev,
            options = opts,
            description = "Jump to previous diagnostic.",
          },
          {
            mode = { "n" },
            lhs = "]d",
            rhs = vim.diagnostic.goto_next,
            options = opts,
            description = "Jump to next diagnostic.",
          },
        })
      end)

      if settings.get_settings("format_on_save") then
        lsp.format_on_save({
          format_opts = {
            async = false,
            timeout_ms = 10000,
          },
          servers = {
            ["gopls"] = { "go" },
            ["rust_analyzer"] = { "rust" },
            ["lua_ls"] = { "lua" },
          },
        })
      end

      lsp.set_preferences({
        suggest_lsp_servers = false,
      })

      lsp.set_sign_icons({
        info = icons.diagnostics.BoldInformation,
        hint = icons.diagnostics.BoldHint,
        warn = icons.diagnostics.BoldWarning,
        error = icons.diagnostics.BoldError,
      })

      vim.diagnostic.config({
        underline = true,
        virtual_text = settings.get_settings("format_on_save"),
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = "always",
          style = "minimal",
          border = "rounded",
          header = "",
          prefix = "",
        },
      })

      local lspconfig = require("lspconfig")

      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      mason_lspconfig.setup({
        ensure_installed = ensure_installed.lsp,
      })

      mason_tool_installer.setup({
        ensure_installed = vim.tbl_flatten({
          ensure_installed.linters,
          ensure_installed.formatters,
        }),
      })

      lspconfig.clangd.setup(require("plugins.lsp.extras.clangd"))
      lspconfig.lua_ls.setup(require("plugins.lsp.extras.lua_ls"))
      lspconfig.eslint.setup(require("plugins.lsp.extras.eslint"))
      lspconfig.gopls.setup(require("plugins.lsp.extras.gopls"))
      lspconfig.rust_analyzer.setup(require("plugins.lsp.extras.rust_analyzer"))
      lspconfig.ocamllsp.setup(require("plugins.lsp.extras.ocamllsp"))

      lsp.skip_server_setup({
        "jdtls",
        "dartls",
      })

      lsp.setup()
    end,
  },
}
