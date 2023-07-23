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
        },
      },
      "onsails/lspkind.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local lsp = require("lsp-zero").preset("lsp-only")

      local settings = require("core.settings")

      local ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "csharp_ls",
        "cssls",
        "emmet_ls",
        "gopls",
        "html",
        "jdtls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "svelte",
        "tailwindcss",
        "tsserver",
        "vuels",
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

      if settings.format_on_save then
        lsp.format_on_save({
          format_opts = {
            async = false,
            timeout_ms = 10000,
          },
          servers = {
            ["clangd"] = { "c", "cpp" },
            ["gopls"] = { "go" },
            ["lua_ls"] = { "lua" },
            ["pyright"] = { "python" },
            ["rust_analyzer"] = { "rust" },
          },
        })
      end

      lsp.set_preferences({
        suggest_lsp_servers = false,
      })

      lsp.set_sign_icons({
        info = "I",
        hint = "H",
        warn = "W",
        error = "E",
      })

      vim.diagnostic.config({
        underline = true,
        virtual_text = settings.virtual_text,
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

      mason_lspconfig.setup({
        ensure_installed = ensure_installed,
      })

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            lens = {
              enable = true,
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            check = {
              enable = true,
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["napi-derive"] = { "napi" },
                ["async-trait"] = { "async_trait" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      })

      lspconfig.gopls.setup({
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          }
        }
      })

      lsp.skip_server_setup({
        "jdtls",
      })

      lsp.setup()
    end,
  },
}
