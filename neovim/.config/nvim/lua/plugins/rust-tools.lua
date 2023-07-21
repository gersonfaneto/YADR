return {
  "simrat39/rust-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
  },
  ft = { "rust" },
  config = function()
    require("rust-tools").setup()
  end,
}
