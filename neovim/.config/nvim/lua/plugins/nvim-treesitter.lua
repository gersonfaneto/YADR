return {
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "f2778bd1a28b74adf5b1aa51aa57da85adfa3d16",
    build = ":TSUpdate",
    event = { "BufNewFile", "BufReadPost" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "windwp/nvim-ts-autotag",
      "HiPhish/nvim-ts-rainbow2",
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        commit = "35a60f093fa15a303874975f963428a5cd24e4a0",
      },
    },
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        indent = {
          enable = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        rainbow = {
          enable = true,
          disable = { "jsx", "html" },
        },
        autotag = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        ensure_installed = {
          "c",
          "cpp",
          "c_sharp",
          "rust",
          "go",
          "java",
          "lua",
          "python",
          "html",
          "css",
          "tsx",
          "javascript",
          "typescript",
          "vue",
          "svelte",
          "fish",
          "bash",
          "json",
          "toml",
          "gitcommit",
          "gitignore",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>vv",
            scope_incremental = false,
            node_incremental = "+",
            node_decremental = "_",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "around a function" },
              ["if"] = { query = "@function.inner", desc = "inner part of a function" },
              ["ac"] = { query = "@class.outer", desc = "around a class" },
              ["ic"] = { query = "@class.inner", desc = "inner part of a class" },
              ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
              ["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
              ["al"] = { query = "@loop.outer", desc = "around a loop" },
              ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
              ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
              ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@parameter.inner"] = "v",
              ["@function.outer"] = "v",
              ["@conditional.outer"] = "V",
              ["@loop.outer"] = "V",
              ["@class.outer"] = "<C-v>",
            },
            include_surrounding_whitespace = false,
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Previous function" },
              ["[c"] = { query = "@class.outer", desc = "Previous class" },
              ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
            },
            goto_next_start = {
              ["]f"] = { query = "@function.outer", desc = "Next function" },
              ["]c"] = { query = "@class.outer", desc = "Next class" },
              ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>pn"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>pp"] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },
}
