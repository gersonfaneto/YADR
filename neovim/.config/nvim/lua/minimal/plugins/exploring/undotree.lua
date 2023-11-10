return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle" },
  config = function()
    vim.g.undotree_HighlightChangedWithSign = 0
    vim.g.undotree_WindowLayout = 4
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
