local M = {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "java" },
      callback = function()
        local found_java = vim.fn.executable("java")

        if not found_java then
          vim.notify("Java isn't present in $PATH.", "error",{ title = "JDTLS" })
          return
        end

        local java_path = vim.fn.exepath("java")

        local jdtls = require("jdtls")
        local jdtls_setup = require("jdtls.setup")

        local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
        local home = vim.fn.expand("$HOME") .. "/"

        local capabilities = utils.plugins.lsp.capabilities.default_capabilities()

        local extendedClientCapabilities = jdtls.extendedClientCapabilities
        extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

        local root_markers = {
          ".git",
          "mvnw",
          "gradlew",
          "pom.xml",
          "build.gradle",
        }

        local root_dir = jdtls_setup.find_root(root_markers)

        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

        if not utils.base.files.is_directory(workspace_dir) then
          os.execute("mkdir " .. workspace_dir)
        end

        local on_attach = function(_, bufnr)
          utils.plugins.lsp.attach.on_attach(_, bufnr)

          utils.base.mappings.bulk_register({
            {
              mode = { "n" },
              lhs = "<leader>jo",
              rhs = ":lua require('jdtls').organize_imports()<CR>",
              description = "Organize Imports.",
            },
            {
              mode = { "n" },
              lhs = "<leader>jv",
              rhs = ":lua require('jdtls').extract_variable()<CR>",
              description = "Extract Variable.",
            },
            {
              mode = { "x" },
              lhs = "<leader>jv",
              rhs = "<ESC>:lua require('jdtls').extract_variable(true)<CR>",
              description = "Extract Variable.",
            },
            {
              mode = { "n" },
              lhs = "<leader>jc",
              rhs = ":lua require('jdtls').extract_constant()<CR>",
              description = "Extract Constant.",
            },
            {
              mode = { "x" },
              lhs = "<leader>jc",
              rhs = "<ESC>:lua require('jdtls').extract_constant(true)<CR>",
              description = "Extract Constant.",
            },
            {
              mode = { "x" },
              lhs = "<leader>jm",
              rhs = "<ESC>:lua require('jdtls').extract_method(true)<CR>",
              description = "Extract Method.",
            },
          }, { prefix = "Java :: ", options = { silent = true, noremap = true, buffer = bufnr } })

          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.java" },
            callback = function()
              local _, _ = pcall(vim.lsp.codelens.refresh)
            end,
          })

          vim.lsp.codelens.refresh()
        end

        local config = {
          cmd = {
            java_path,
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-javaagent:" .. jdtls_path .. "/lombok.jar",
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",

            "-jar",
            vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
            "-configuration",
            jdtls_path .. "/config_linux",
            "-data",
            workspace_dir,
          },
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = root_dir,
          settings = {
            java = {
              configuration = {
                runtimes = {},
              },
              maven = {
                downloadSources = true,
              },
              implementationsCodeLens = {
                enabled = true,
              },
              referencesCodeLens = {
                enabled = true,
              },
              references = {
                includeDecompiledSources = true,
              },
              format = {
                enabled = false,
              },
            },
            signatureHelp = {
              enabled = true,
            },
            completion = {
              favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.base.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
              },
              importOrder = {
                "java",
                "javax",
                "com",
                "org",
              },
            },
            extendedClientCapabilities = extendedClientCapabilities,
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              useBlocks = true,
            },
          },
          flags = {
            allow_incremental_sync = true,
          },
          init_options = {
            bundles = {},
          },
        }

        jdtls.start_or_attach(config)
      end,
    })
  end,
}

return M
